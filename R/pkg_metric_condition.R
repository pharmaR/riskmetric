#' A pkg_metric subclass for general metric evaluation conditions
#'
#' @param x an object to wrap in a \code{pkg_metric_condition} class
#' @param ... additional arguments added as attributes to object \code{x}
#' @param subclass an optional subclass of \code{pkg_metric_condition} to
#'   include
#' @noRd
as_pkg_metric_condition <- function(x, ..., subclass = c()) {
  dots <- list(...)
  if (length(names(dots)) != length(dots))
    stop("All ellipsis arguments must be named")
  dots <- dots[setdiff(names(dots), "class")]
  attributes(x)[names(dots)] <- dots
  class(x) <- c(subclass, "pkg_metric_condition", class(x))
  x
}
