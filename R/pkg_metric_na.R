#' A pkg_metric subclass for when metrics are explicitly not applicable
#'
pkg_metric_na <- function(message = NULL) {
  pkg_metric(NA, message = message, class = "pkg_metric_na")
}
