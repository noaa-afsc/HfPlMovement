#' Predicted Points for Ribbon Seals
#'
#' Predicted points for ribbon seals based on the `aniMotum` package
#' 
#' @import sf
#' @format ## `hf_predict_pts`
#' An sf data frame with 1,055,323 rows and 20 columns:
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
"hf_predict_pts"

#' Predicted Lines for Ribbon Seals
#'
#' Predicted lines for ribbon seals based on the `aniMotum` package
#'
#' @import sf
#' @format ## `hf_predict_lines`
#' An sf data frame with 71 rows and 11 columns:
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
"hf_predict_lines"

#' Predicted Points for Spotted Seals
#'
#' Predicted points for spotted seals based on the `aniMotum` package
#' 
#' @import sf
#' @format ## `pl_predict_pts`
#' An sf data frame with 548,184 rows and 21 columns:
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
"pl_predict_pts"

#' Predicted Lines for Spotted Seals
#'
#' Predicted lines for spotted seals based on the `aniMotum` package
#'
#' @import sf
#' @format ## `pl_predict_lines`
#' An sf data frame with 41 rows and 11 columns:
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
"pl_predict_lines"