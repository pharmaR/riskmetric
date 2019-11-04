#' Retrieve a list of BugReports metadata
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.bug_reports <- function(x, ...) {
  UseMethod("pkg_ref_cache.bug_reports")
}



pkg_ref_cache.bug_reports.default <- function(x, ...) {
  scrape_bug_reports(x, ...)
}



#' Helper for structuring bug reports
bug_report_metadata <- function(bug_reports_data, x) {
  structure(bug_reports_data,
    class = c(
      paste0(x$bug_reports_host, "_bug_report"),
      "bug_report",
      class(bug_reports_data)))
}



# Helper for scraping bug reports depending on url host name
scrape_bug_reports <- function(x, ...) {
  UseMethod("scrape_bug_reports", structure(1L, class = x$bug_reports_host))
}


scrape_bug_reports.default <- function(x, ...) {
  stop("BugReports host not implemented")
}



#' @importFrom gh gh
scrape_bug_reports.github <- function(x, ...) {
  owner_repo_issues <- gsub(".*github[^/]*/(.*)", "\\1", x$bug_reports_url)
  out <- unclass(gh(
    paste0('/repos/', owner_repo_issues, '?state=all'),
    .limit = 30))
  bug_report_metadata(out, x)
}



#' @importFrom curl curl
#' @importFrom urltools url_encode
#' @importFrom jsonlite parse_json
scrape_bug_reports.gitlab <- function(x, ...) {
  owner_repo_issues <- gsub(".*gitlab[^/]*/(.*)", "\\1", x$bug_reports_url)
  owner_repo <- gsub("(.*)/issues", "\\1", owner_repo_issues)
  out <- parse_json(curl(sprintf(
    "https://gitlab.com/api/v4/projects/%s/issues",
    url_encode(owner_repo))))
  bug_report_metadata(out, x)
}
