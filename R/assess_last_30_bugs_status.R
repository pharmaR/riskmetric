#' Assess how many recent BugReports have been closed
#'
#' @eval roxygen_assess_family(
#'   "last_30_bugs_status",
#'   "a logical vector indicating whether a recent BugReport was closed",
#'   dontrun = TRUE)
#'
#' @export
assess_last_30_bugs_status <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_last_30_bugs_status", {
    bug_reports_status(x)
  })
}

attributes(assess_last_30_bugs_status)$column_name <- "bugs_status"
attributes(assess_last_30_bugs_status)$label <- "vector indicating whether BugReports status is closed"



#' Retrieve statuses of bug reports
#'
#' @param x a \code{pkg_ref} package reference object
#' @param ... additional arguments passed on to S3 methods, rarely used
#' @return a logical vector indicating whether a bug report is closed
#'
#' @export
bug_reports_status <- function(x, ...) {
  UseMethod("bug_reports_status", x$bug_reports)
}


#' @export
#' @method bug_reports_status github_bug_report
bug_reports_status.github_bug_report <- function(x, ...) {
  vapply(x$bug_reports, "[[", character(1L), "state") == "closed"
}



#' @export
#' @method bug_reports_status gitlab_bug_report
bug_reports_status.gitlab_bug_report <- function(x, ...) {
  vapply(x$bug_reports, "[[", character(1L), "state") == "closed"
}



#' Score a package for number of recently opened BugReports that are now closed
#'
#' @eval roxygen_score_family("last_30_bugs_status", dontrun = TRUE)
#' @return a fractional value indicating percentage of last 30 bug reports that
#'   are now closed
#'
#' @export
metric_score.pkg_metric_last_30_bugs_status <- function(x, ...) {
  mean(x, na.rm = TRUE)
}

attributes(metric_score.pkg_metric_last_30_bugs_status)$label <- 
  "The fraction of the last 30 bugs which have already been closed."
