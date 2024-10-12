#' @title Find start/end times of telemtry data gaps
#' @description determine the start/end time of gaps between observed
#' locations that are larger than the interval specified.
#' @param d A data set of telemetry locations and times; must have `datetime`
#' and `speno` columns.
#' @param dtMax specified minimum time interval for a gap. Defaults
#' to \code{dtMax=7, unit="days"}.
#' @param unit Unit of time of the gap specification. Defaults to \code{"days"}.
#' @param ... Ignored arguments
#' @author Josh M. London
#' @export
#'

find_gaps <- function(d, dtMax=7, unit = "days", ...) {
  d <- d |> dplyr::group_by(speno) |> 
    tidyr::nest() |> 
    dplyr::rowwise() |> 
    dplyr::mutate(gaps = list(Tides::gapsts(data$datetime,dtMax,unit))) |> 
    dplyr::select(speno,gaps) |> 
    tidyr::unnest(cols = c(gaps))

  return(d)
}