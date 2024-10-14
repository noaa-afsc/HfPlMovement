library(duckdb)
library(dbplyr)
library(dplyr)
library(sf)
library(aniMotum)

con <- DBI::dbConnect(duckdb())

DBI::dbExecute(con, "INSTALL httpfs; LOAD httpfs;")
# dbExecute(con, "INSTALL 'spatial'; LOAD 'spatial';")

max_no_na <- function(x) ifelse( !all(is.na(x)), max(x, na.rm=T), NA)

tbl_deploy <- tbl(con, "read_parquet('https://github.com/noaa-afsc/mml-cefi-iceseal-data/raw/main/tbl_deploy/tbl_deploy.parquet')") |> 
  collect() |> 
    summarise(deployids = list(unique(deployid)),
  serial_nums = list(unique(serial_num)),
  ptts = list(unique(ptt)),
  tag_families = list(unique(tag_family)),
  end_dt = as.POSIXct(max_no_na(end_dt), tx="UTC"),
.by = c(speno, species, age, sex, deploy_dt, 
        field_effort_lku)) |> 
dplyr::mutate(end_dt = case_when(
        lubridate::year(deploy_dt) == 2024 ~ as.POSIXct("2024-12-31"),
        .default = end_dt
))


select_spenos <- tbl(con, "read_parquet('https://github.com/noaa-afsc/mml-cefi-iceseal-data/raw/main/locs_obs/locs_obs.parquet')") |> 
  dplyr::collect() |> 
  dplyr::mutate(n_tags = n_distinct(tag_family), .by=speno) |> 
  dplyr::filter(!(tag_family == 'SPOT' & n_tags == 1)) |> 
  dplyr::distinct(speno) |> 
  dplyr::pull()


locs_obs <- tbl(con, "read_parquet('https://github.com/noaa-afsc/mml-cefi-iceseal-data/raw/main/locs_obs/locs_obs.parquet')") |>
  dplyr::filter(speno %in% select_spenos) |> 
  dplyr::mutate(end_dt_splash = case_when(
    tag_family != 'SPOT' ~ end_dt, 
    TRUE ~ NA)) |> 
  dplyr::filter(between(locs_dt,
                        deploy_dt,
                        end_dt_splash)) |> 
  dplyr::rename(datetime=locs_dt) |> 
  dplyr::mutate(
    quality = case_when(
      type == 'FastGPS' ~ 'G',
      type == 'User' ~ 'G',
      .default = quality
    )
  ) |> 
  dplyr::filter(!quality %in% c('Z')) |> 
  dplyr::select(speno,deployid,species,
                tag_family,
                datetime,
                quality,
                error_semi_major_axis,
                error_semi_minor_axis,
                error_ellipse_orientation,
                error_radius,
                geometry = geom
                ) |> 
  dplyr::collect() 

DBI::dbDisconnect(con, disconnect = TRUE)

proj <- "+proj=laea +lat_0=90 +lon_0=180 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +type=crs"

locs_obs <- locs_obs |> 
  dplyr::group_by(speno) |> 
  dplyr::arrange(datetime, error_radius) |> 
  dplyr::mutate(
    rank = 1L,
    rank = case_when(duplicated(datetime, fromLast = FALSE) ~
                       lag(rank) + 1L, TRUE ~ rank))  |> 
  dplyr::filter(rank == 1)  |>  
  dplyr::arrange(speno,datetime)  |>  
  dplyr::ungroup() |> 
  sf::st_as_sf() |> 
  sf::st_set_crs(4326) |> 
  sf::st_transform(proj)

speno_counts <- locs_obs |> 
  sf::st_drop_geometry() |> 
  dplyr::group_by(speno) |> 
  dplyr::tally()

speno_keep <- speno_counts |> 
  dplyr::filter(n >= 10) %>%
  dplyr::select(speno) |> 
  dplyr::pull()

locs_obs <- locs_obs |> 
  dplyr::filter(speno %in% speno_keep)

deploy_gaps <- find_gaps(locs_obs)

locs_fit <- aniMotum::fit_ssm(
  x = locs_obs,
  vmax = 8,
  model = "crw",
  time.step = 0.25,
  id = "speno",
  date = "datetime",
  lc = "quality",
  epar = c(
    "error_semi_major_axis",
    "error_semi_minor_axis",
    "error_ellipse_orientation"
  ),
  tz = "UTC"
)

locs_fit <- locs_fit |> dplyr::filter(converged)

hf_predict_pts <-
  aniMotum::grab(locs_fit,
       what = "predicted",
       as_sf = TRUE,
       group = TRUE) |> 
  dplyr::rename(speno = id,
         datetime = date) |> 
  dplyr::left_join(tbl_deploy, by = 'speno') |> 
  dplyr::filter(species == "Ribbon seal")

hf_predict_pts <- hf_predict_pts |> 
  filter_predicts(deploy_gaps) |> 
  dplyr::filter(!in_gap)


hf_predict_lines <- hf_predict_pts %>% 
  dplyr::group_by(speno) %>%
  dplyr::summarise(do_union = FALSE) %>%
  sf::st_cast("LINESTRING") %>%
  dplyr::left_join(tbl_deploy)

pl_predict_pts <-
  aniMotum::grab(locs_fit,
       what = "predicted",
       as_sf = TRUE,
       group = TRUE) |> 
  dplyr::rename(speno = id,
         datetime = date) |> 
  dplyr::left_join(tbl_deploy, by = 'speno') |> 
  dplyr::filter(species == "Spotted seal")

pl_predict_lines <- pl_predict_pts %>% 
  dplyr::group_by(speno) %>%
  dplyr::summarise(do_union = FALSE) %>%
  sf::st_cast("LINESTRING") %>%
  dplyr::left_join(tbl_deploy)

usethis::use_data(hf_predict_pts, hf_predict_lines,
                  pl_predict_pts, pl_predict_lines,
                  version = 3,
                  overwrite = TRUE)


