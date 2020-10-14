#' A pkg_metric subclass for when pkg_metrics have not yet been implemented
#'
#' @param x a \code{pkg_metric} object to wrap in a \code{pkg_metric_todo}
#'   subclass
#' @param message an optional message directing users and potential contributors
#'   toward any ongoing work or first steps toward development.
#'
as_pkg_metric_todo <- function(x, message = NULL) {
  as_pkg_metric_condition(NA_real_, message = message, subclass = "pkg_metric_todo")
}
