#' Cache package's remote display page HTML
#'
#' @family package reference cache
#'
pkg_ref_cache.web_html <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.web_html")
}



#' @importFrom xml2 read_html
pkg_ref_cache.web_html.pkg_cran_remote <- function(x, name, ...) {
  xml2::read_html(x$web_url)
}
