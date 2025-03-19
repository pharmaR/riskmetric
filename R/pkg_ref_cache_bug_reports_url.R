#' @describeIn riskmetric_metadata_caching
#' Get the BugReports url
#'
#' @family package reference cache
#' @keywords internal
#'
#' @usage NULL
#' @export
pkg_ref_cache.bug_reports_url <- function(x, ...) {
  UseMethod("pkg_ref_cache.bug_reports_url")
}

#' @importFrom utils packageDescription
#' @keywords internal
#' @export
#' @method pkg_ref_cache.bug_reports_url pkg_source
pkg_ref_cache.bug_reports_url.pkg_source <- function(x, ...) {
  # fake a library location given the package source code path where the
  # description can be found, revert on exit when no longer needed

  packageDescription(x$name, dirname(x$path))$BugReports
}

#' @importFrom utils packageDescription
#' @keywords internal
#' @export
#' @method pkg_ref_cache.bug_reports_url pkg_install
pkg_ref_cache.bug_reports_url.pkg_install <- function(x, ...) {
  packageDescription(x$name)$BugReports
}

#' @importFrom xml2 xml_find_all xml_attr
#' @keywords internal
#' @export
#' @method pkg_ref_cache.bug_reports_url pkg_cran_remote
pkg_ref_cache.bug_reports_url.pkg_cran_remote <- function(x, ...) {
  # scrape CRAN package webpage for BugReports links
  bug_reports_xpath <- "//td[.='BugReports:']/following::td[1]/a"
  bug_reports_link <- xml_find_all(x$web_html, xpath = bug_reports_xpath)
  xml_attr(bug_reports_link, "href")
}

#' @importFrom xml2 xml_find_all xml_attr
#' @keywords internal
#' @export
#' @method pkg_ref_cache.bug_reports_url pkg_bioc_remote
pkg_ref_cache.bug_reports_url.pkg_bioc_remote <- function(x, ...) {
  # scrape CRAN package webpage for BugReports links
  bug_reports_xpath <- "//td[.='BugReports']/following::td[1]/a"
  bug_reports_link <- xml_find_all(x$web_html, xpath = bug_reports_xpath)
  xml_attr(bug_reports_link, "href")
}
