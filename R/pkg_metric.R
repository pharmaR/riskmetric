#' @export
new_pkg_metric <- function(x, ..., class = c()) {
  structure(x, ..., class = c(class, "pkg_metric", class(x)))
}



#' @export
vec_ptype_abbr.pkg_metric <- function(x, ...) {
  "pkg_metric"
}



#' @export
format_pillar_shaft_pkg_metric <- function(x, ...) {
  UseMethod("format_pillar_shaft_pkg_metric")
}



#' @export
format_pillar_shaft_pkg_metric.pkg_metric_error <- function(x, ...) {
  class_str <- gsub("_", " ", gsub("^pkg_metric_", "", class(x)[[1]]))
  pillar::style_na(paste0("<", class_str, ">"))
}



#' @export
format_pillar_shaft_pkg_metric.pkg_metric <- function(x, ...) {
  class_str <- gsub("_", " ", gsub("^pkg_metric_", "", class(x)[[1]]))
  paste0("<", class_str, ">")
}
