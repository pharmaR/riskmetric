#' @export
pillar_shaft.list_of_pkg_ref <- function(x, ...) {
  out <- vapply(x, format_pillar_shaft_pkg_ref, character(1L))
  pillar::new_pillar_shaft_simple(out, align = "left")
}
