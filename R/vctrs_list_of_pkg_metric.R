#' @export
pillar_shaft.list_of_pkg_metric <- function(x, ...) {
  x <- vapply(x, format_pillar_shaft_pkg_metric, character(1L))
  pillar::new_pillar_shaft_simple(x, align = "left")
}
