#' @describeIn riskmetric_metadata_caching
#' Run R CMD check and capture the results
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.r_cmd_check <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.r_cmd_check")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.r_cmd_check default
pkg_ref_cache.r_cmd_check.default <- function(x, name, ...) {
  NA
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.r_cmd_check pkg_source
pkg_ref_cache.r_cmd_check.pkg_source <- function(x, name, ...) {
  devtools::check(x$path, quiet = TRUE)
}
