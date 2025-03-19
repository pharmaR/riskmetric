#' @describeIn riskmetric_metadata_caching
#' Cache appropriate urls for NEWS files
#'
#' @family package reference cache
#' @keywords internal
#'
#' @usage NULL
#' @export
pkg_ref_cache.news_urls <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.news_urls")
}

#' @importFrom xml2 xml_attrs
#' @keywords internal
#' @export
#' @method pkg_ref_cache.news_urls pkg_cran_remote
pkg_ref_cache.news_urls.pkg_cran_remote <- function(x, name, ...) {
  # scrape CRAN html for NEWS links
  news_links <- xml2::xml_find_all(x$web_html, xpath = '//a[.="NEWS"]')

  # add NEWS link url metadata to package environment
  sprintf("%s/%s",
    x$web_url,
    vapply(xml2::xml_attrs(news_links), "[", character(1L), "href"))
}

#' @importFrom xml2 xml_attrs
#' @keywords internal
#' @export
#' @method pkg_ref_cache.news_urls pkg_bioc_remote
pkg_ref_cache.news_urls.pkg_bioc_remote <- function(x, name, ...) {
  # scrape Bioconductor package webpage for NEWS links
  relative_path <- sprintf("../news/%s/NEWS", x$name)
  news_link_xpath <- sprintf('//a[@href="%s"]', relative_path)
  news_links <- xml2::xml_find_all(x$web_html, xpath = news_link_xpath)

  # add NEWS link url metadata to package environment
  xml2::url_absolute(
    vapply(xml2::xml_attrs(news_links), "[", character(1L), "href"),
    x$web_url)
}
