#' A pkg_metric subclass for when metrics are explicitly not applicable
#'
#' @param message an optional message explaining why a metric is not applicable.
#' 
as_pkg_metric_na <- function(x, message = NULL) {
  as_pkg_metric_condition(x, subclass = "pkg_metric_na")
}
