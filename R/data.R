#' Predicted Points for Ribbon and Spotted Seals
#'
#' Predicted points for ribbon and spotted seals based on the `aniMotum` package
#' 
#' @import sf
#' @format ## `predict_pts_sf`
#' An sf data frame with 1,603,507 rows and 21 columns:
#' \describe{
#'   \item{speno}{Seal Identifier ('SPEcimen NO.')}
#'   \item{datetime}{date-time value in UTC for the predicted location}
#'   \item{u}{see aniMotum documentation}
#'   \item{v}{see aniMotum documentation}
#'   \item{u.se}{see aniMotum documentation}
#'   \item{v.se}{see aniMotum documentation}
#'   \item{x.se}{see aniMotum documentation}
#'   \item{y.se}{see aniMotum documentation}
#'   \item{s}{see aniMotum documentation}
#'   \item{s.se}{see aniMotum documentation}
#'   \item{geometry}{Simple Feature POINT geometry with CRS:+proj=laea +lat_0=90 +lon_0=180 +x_0=0 +y_0=0 +datum=WGS84 +units=km +no_defs +type=crs}
#'   \item{species}{seal species; common name}
#'   \item{age}{age class of seal at start of deployment}
#'   \item{sex}{sex of seal. "F"= female; "M"=male}
#'   \item{deploy_dt}{date-time value in UTC that deployment started}
#'   \item{field_effort_lku}{categorical identifier for the field effort}
#'   \item{deployids}{list of deployids; more than one if multiple tags}
#'   \item{serial_nums}{list of serial numbers; more than one if mulitple tags}
#'   \item{ptts}{Argos PTT IDs; more than one if mulitple tags}
#'   \item{tag_families}{tag family; more than one if multiple tags}
#'   \item{end_dt}{date-time value in UTC when the last deployment ended}
#' }
#' @source <https://github.com/noaa-afsc/mml-cefi-iceseal-data/raw/main/locs_obs/locs_obs.parquet>
"predict_pts_sf"

#' Predicted Lines for Ribbon and Spotted Seals
#'
#' Predicted lines for ribbon and spotted seals based on the `aniMotum` package
#'
#' @import sf
#' @format ## `predict_lines_sf`
#' An sf data frame with 112 rows and 12 columns:
#' \describe{
#'   \item{speno}{Seal Identifier ('SPEcimen NO.')}
#'   \item{geometry}{Simple Feature LINESTRING geometry with CRS:+proj=laea +lat_0=90 +lon_0=180 +x_0=0 +y_0=0 +datum=WGS84 +units=km +no_defs +type=crs}
#'   \item{species}{seal species; common name}
#'   \item{age}{age class of seal at start of deployment}
#'   \item{sex}{sex of seal. "F"= female; "M"=male}
#'   \item{deploy_dt}{date-time value in UTC that deployment started}
#'   \item{field_effort_lku}{categorical identifier for the field effort}
#'   \item{deployids}{list of deployids; more than one if multiple tags}
#'   \item{serial_nums}{list of serial numbers; more than one if mulitple tags}
#'   \item{ptts}{Argos PTT IDs; more than one if mulitple tags}
#'   \item{tag_families}{tag family; more than one if multiple tags}
#'   \item{end_dt}{date-time value in UTC when the last deployment ended}
#' }
#' @source <https://github.com/noaa-afsc/mml-cefi-iceseal-data/raw/main/locs_obs/locs_obs.parquet>
"predict_lines_sf"