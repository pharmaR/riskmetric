#' A pkg_metric subclass for general metric evaluation conditions
#'
#' @param message an optional message explaining why a metric is not applicable.
#'
as_pkg_metric_condition <- function(x, ..., subclass = c()) {
  dots <- list(...)
  if (length(names(dots)) != length(dots))
    stop("All ellipsis arguments must be named")
  dots <- dots[setdiff(names(dots), "class")]
  attributes(x)[names(dots)] <- dots
  class(x) <- c(subclass, "pkg_metric_condition", class(x))
  x
}
