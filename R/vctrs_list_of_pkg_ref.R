#' @export
pillar_shaft.list_of_pkg_ref <- function(x, ...) {
  out <- vapply(x, format, character(1L))
  pillar::new_pillar_shaft_simple(out, align = "left")
}
