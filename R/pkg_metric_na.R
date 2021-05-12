#' A pkg_metric subclass for when metrics are explicitly not applicable
#'
#' @param x a \code{pkg_metric} object to wrap in a \code{pkg_metric_na}
#'   subclass
#' @param message an optional message explaining why a metric is not applicable.
#' @param a \code{pkg_metric} object after wrap in a \code{pkg_metric_na}
#' @return a \code{pkg_metric} object after wrap in a \code{pkg_metric_na}
#' @keywords internal
as_pkg_metric_na <- function(x, message = NULL) {
  as_pkg_metric_condition(x, message = message, subclass = "pkg_metric_na")
}
