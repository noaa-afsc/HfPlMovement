library(duckdb)
library(dbplyr)
library(dplyr)
library(sf)
library(aniMotum)

con <- dbConnect(duckdb())

dbExecute(con, "INSTALL httpfs; LOAD httpfs;")
# dbExecute(con, "INSTALL 'spatial'; LOAD 'spatial';")

locs_obs <- tbl(con, "read_parquet('https://github.com/noaa-afsc/mml-cefi-iceseal-data/raw/main/locs_obs/locs_obs.parquet')") |>
  dplyr::filter(between(locs_dt,
                        deploy_dt,
                        end_dt)) |> 
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
                datetime,
                quality,
                error_semi_major_axis,
                error_semi_minor_axis,
                error_ellipse_orientation,
                error_radius,
                geometry = geom
                ) |> 
  collect() 

dbDisconnect(con, disconnect = TRUE)

proj <- "+proj=laea +lat_0=90 +lon_0=180 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +type=crs"

locs_obs <- locs_obs |> 
  group_by(speno) |> 
  arrange(datetime, error_radius) |> 
  mutate(
    rank = 1L,
    rank = case_when(duplicated(datetime, fromLast = FALSE) ~
                       lag(rank) + 1L, TRUE ~ rank))  |> 
  dplyr::filter(rank == 1)  |>  
  arrange(speno,datetime)  |>  
  ungroup() |> 
  st_as_sf() |> 
  st_set_crs(4326) |> 
  st_transform(proj)

speno_counts <- locs_obs |> 
  sf::st_drop_geometry() |> 
  group_by(speno) |> 
  tally()

speno_keep <- speno_counts |> 
  filter(n >= 10) %>%
  select(speno) |> 
  pull()

locs_obs <- locs_obs |> 
  filter(speno %in% speno_keep)


locs_fit <- fit_ssm(
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
