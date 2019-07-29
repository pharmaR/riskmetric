pkg_ref_cache.web_html <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.web_html")
}

#' @importFrom xml2 read_html
pkg_ref_cache.web_html.pkg_cran_remote <- function(x, name, ...) {
  x$web_html <- xml2::read_html(x$web_url)
}
