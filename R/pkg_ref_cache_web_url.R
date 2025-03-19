#' @describeIn riskmetric_metadata_caching
#' Cache package's remote web URL
#'
#' @family package reference cache
#' @keywords internal
#'
#' @usage NULL
#' @export
pkg_ref_cache.web_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.web_url")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.web_url pkg_cran_remote
pkg_ref_cache.web_url.pkg_cran_remote <- function(x, name, ...) {
  sprintf("%s/web/packages/%s", x$repo_base_url, x$name)
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.web_url pkg_bioc_remote
pkg_ref_cache.web_url.pkg_bioc_remote <- function(x, name, ...) {
  sprintf("%s/html/%s.html", x$repo_base_url, x$name)
}
