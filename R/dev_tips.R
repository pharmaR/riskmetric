#' Provide tips for improving a metric
#'
#' @param x a pkg_metric object
#' @param ... additional arguments unused
#'
#' @export
dev_tips <- function(x, ...) {
  UseMethod("dev_tips")
}
