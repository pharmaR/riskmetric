#' @importFrom utils .DollarNames
#' @export
`.DollarNames.pkg_ref` <- function(x, pattern) {
  names(x)
}



#' @export
names.pkg_ref <- function(x, ...) {
  c(unname(available_pkg_ref_fields(x)), bare_env(x, names(x)))
}
