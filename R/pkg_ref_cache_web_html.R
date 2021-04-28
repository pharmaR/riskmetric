#' Cache package's remote display page HTML
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.web_html <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.web_html")
}



#' @importFrom httr content GET
pkg_ref_cache.web_html.pkg_remote <- function(x, name, ...) {
  # suppress messages when httr assumes a default content parameters
  suppressMatchingConditions(
    httr::content(httr::GET(x$web_url)),
    messages = "default")
}
