#' A pkg_metric subclass for when pkg_metrics have not yet been implemented
#'
#' @param message an optional message directing users and potential contributors
#'   toward any ongoing work or first steps toward development.
#'
pkg_metric_todo <- function(message = NULL) {
  pkg_metric(NA_real_, message = message, class = "pkg_metric_todo")
}
