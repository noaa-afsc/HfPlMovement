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

#' @description determine which points occur during identified gaps.
#' @param pts A data set of telemetry locations and times; must have `datetime`
#' and `speno` columns.
#' @param gaps data frame of start(t1) and end(t2) times from \code{find_gaps()}.
#' @author Josh M. London
#' @export
#'
filter_predicts <- function(pts, gaps) {
  pts$in_gap <- FALSE
  for (spn in unique(gaps$speno)) {
    speno_pts <- pts |> dplyr::filter(speno == spn)
    speno_gaps <- gaps |> dplyr::filter(speno == spn)

    in_gap <- check_between(speno_pts$datetime,
                            start = speno_gaps$t1,
                            end = speno_gaps$t2)
    
    pts[pts$speno == spn,]$in_gap <- in_gap
  }
  return(pts)
}

#' @description check if times occur between start and end
#' @param x a vector of datetime values.
#' @param start vector of start times.
#' @param end vector of end times
#' @author Josh M. London
#' @export
#'
check_between <- function (x, start, end) {
  res <- purrr::map_lgl(x, ~any(. > start & . < end))
  return(res)
}