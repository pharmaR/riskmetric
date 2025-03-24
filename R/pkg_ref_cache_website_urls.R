#' @describeIn riskmetric_metadata_caching
#' Cache package's Website URL
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.website_urls <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.website_urls")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.website_urls pkg_remote
pkg_ref_cache.website_urls.pkg_remote <- function(x, name, ...) {
  url_xpath <- "//td[.='URL:']/following::td[1]/a"
  url  <- xml2::xml_text(xml2::xml_find_all(x$web_html, url_xpath))
  if (length(url) == 0) return(character(0L))
  url
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.website_urls default
pkg_ref_cache.website_urls.default <- function(x, name, ...) {
  if (!"URL" %in% colnames(x$description)) return(character(0L))
  trimws(strsplit(x$description[, "URL"], ",")[[1]])
}
