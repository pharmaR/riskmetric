#' Retrieve a list of BugReports metadata
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
pkg_ref_cache.bug_reports <- function(x, ...) {
  UseMethod("pkg_ref_cache.bug_reports")
}


pkg_ref_cache.bug_reports.default <- function(x, ...) {
  scrape_bug_reports(x, ...)
}



#' Helper for structuring bug reports
#'
#' @param bug_reports_data data to represent a bug report history - generally a
#'   return object from making a request to a repository's issues API
#' @param x a \code{pkg_ref} object where a \code{bug_reports_host} field can be
#'   found
#' @return a \code{bug_reports_host} field
#' @keywords internal
bug_report_metadata <- function(bug_reports_data, x) {
  structure(bug_reports_data,
    class = c(
      paste0(x$bug_reports_host, "_bug_report"),
      "bug_report",
      class(bug_reports_data)))
}



# Helper for scraping bug reports depending on url host name
scrape_bug_reports <- function(x, ...) {
  disp_class <- x$bug_reports_host %||% "NULL"
  UseMethod("scrape_bug_reports", structure(list(), class = disp_class))
}



scrape_bug_reports.default <- function(x, ...) {
  if (is.null(x$bug_reports_host) || length(x$bug_reports_host) == 0L)
    stop("package DESCRIPTION does not have a BugReports field")
  else
    stop(sprintf(
      "scraping bug reports fromm BugReports host '%s' not implemented",
      x$bug_reports_host))
}



#' @importFrom httr GET content
#' @keywords internal
scrape_bug_reports.github <- function(x, ...) {
  owner_repo_issues <- gsub(
    ".*github[^/]*/([^/]+/[^/]+).*",
    "\\1",
    x$bug_reports_url)
  resp <- httr::GET(sprintf(
    "%s/repos/%s/issues?state=all&per_page=%s",
    getOption("riskmetric.github_api_host"),
    owner_repo_issues,
    30))
  out <- httr::content(resp, as = "parsed")
  bug_report_metadata(out, x)
}



#' @importFrom httr GET content
#' @importFrom urltools url_encode
#' @keywords internal
scrape_bug_reports.gitlab <- function(x, ...) {
  owner_repo_issues <- gsub(".*gitlab[^/]*/(.*)", "\\1", x$bug_reports_url)
  owner_repo <- gsub("(.*)/issues", "\\1", owner_repo_issues)
  resp <- httr::GET(sprintf(
    "%s/projects/%s/issues?per_page=%s",
    getOption("riskmetric.gitlab_api_host"),
    url_encode(owner_repo),
    30))
  out <- httr::content(resp, as = "parsed")
  bug_report_metadata(out, x)
}
