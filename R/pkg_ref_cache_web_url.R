#' Cache package's remote web URL
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
#' @export
pkg_ref_cache.web_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.web_url")
}

#' @export
#' @method pkg_ref_cache.web_url pkg_cran_remote
pkg_ref_cache.web_url.pkg_cran_remote <- function(x, name, ...) {
  sprintf("%s/web/packages/%s", x$repo_base_url, x$name)
}

#' @export
#' @method pkg_ref_cache.web_url pkg_bioc_remote
pkg_ref_cache.web_url.pkg_bioc_remote <- function(x, name, ...) {
  sprintf("%s/html/%s.html", x$repo_base_url, x$name)
}
