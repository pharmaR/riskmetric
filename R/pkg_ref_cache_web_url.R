#' Cache package's remote web URL
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @keywords internal
pkg_ref_cache.web_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.web_url")
}



pkg_ref_cache.web_url.pkg_cran_remote <- function(x, name, ...) {
  sprintf("%s/web/packages/%s", x$repo_base_url, x$name)
}



pkg_ref_cache.web_url.pkg_bioc_remote <- function(x, name, ...) {
  sprintf("%s/html/%s.html", x$repo_base_url, x$name)
}
