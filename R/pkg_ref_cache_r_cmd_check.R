#' Run R CMD check and capture the results
#'
#' @family package reference cache
#' @keywords internal
#'
#' @usage NULL
#' @export
pkg_ref_cache.r_cmd_check <- function(x, ...) {
  UseMethod("pkg_ref_cache.r_cmd_check")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.r_cmd_check default
pkg_ref_cache.r_cmd_check.default <- function(x, ...) {
  NA
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.r_cmd_check pkg_source
pkg_ref_cache.r_cmd_check.pkg_source <- function(x, ...) {
  devtools::check(x$path, quiet = TRUE)
}
