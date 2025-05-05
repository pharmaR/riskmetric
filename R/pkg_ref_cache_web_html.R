#' @describeIn riskmetric_metadata_caching
#' Cache package's remote display page HTML
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.web_html <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.web_html")
}

#' @importFrom httr content GET
#' @keywords internal
#' @export
#' @method pkg_ref_cache.web_html pkg_remote
pkg_ref_cache.web_html.pkg_remote <- function(x, name, ...) {
  # suppress messages when httr assumes a default content parameters
  suppressMatchingConditions(
    httr::content(httr::GET(x$web_url)),
    messages = "default")
}
