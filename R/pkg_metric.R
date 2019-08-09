#' A helper for structuring assessment return objects for dispatch with the
#' score function
#'
#' @param x data to store as a \code{pkg_metric}
#' @param ... additional attributes to bind to the \code{pkg_metric} object
#' @param class a subclass to differentiate the \code{pkg_metric} object
#'
#' @return a \code{pkg_metric} object
#'
#' @export
#'
pkg_metric <- function(x, ..., class = c()) {
  structure(x, ..., class = c(class, "pkg_metric", class(x)))
}




#' @importFrom vctrs vec_ptype_abbr
#' @method vec_ptype_abbr pkg_metric
#' @export
vec_ptype_abbr.pkg_metric <- function(x, ...) {
  "pkg_metric"
}



#' @export
format.pkg_metric_error <- function(x, ...) {
  class_str <- gsub("^pkg_metric_", "", class(x)[[1]])
  pillar::style_na(paste0("<", class_str, ">"))
}



#' @export
format.pkg_metric <- function(x, ...) {
  class_str <- gsub("^pkg_metric_", "", class(x)[[1]])
  data_str <- with_unclassed_to(x, "pkg_metric", pillar::pillar_shaft(x))
  paste0(capture.output(data_str), collapse = "")
}
