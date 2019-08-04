#' A helper for structuring assessment return objects for dispatch with the
#' score function
pkg_metric <- function(x, ..., label = NULL, class = c()) {
  structure(x, ..., label = label, class = c(class, "pkg_metric", class(x)))
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
