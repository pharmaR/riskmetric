#' Assess a package for the presence of a url field where bugs can be reported.
#'
#' @eval roxygen_assess_family(
#' "has_bug_reports_url",
#' "a character value containing the BugReports field contents")
#'
#' @export
assess_has_bug_reports_url <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_has_bug_reports_url", {
    as.character(x$bug_reports_url)
  })
}

# assign a friendly name for assess column
attr(assess_has_bug_reports_url,"column_name") <- "has_bug_reports_url"
attr(assess_has_bug_reports_url,"label") <- "presence of a bug reports url in repository"



#' @export
assess_has_bug_reports_url.pkg_ref <- function(x, ...) {
  pkg_metric(class = "pkg_metric_has_bug_reports_url", {
    length(x$bug_reports_url)
  })
}



#' Score a package for the presence of a bug report url
#'
#' @eval roxygen_score_family("has_bug_reports_url")
#'
#' @return A logical value indicating whether the package has a BugReports field
#'   filled in
#'
#' @export
metric_score.pkg_metric_has_bug_reports_url <- function(x, ...) {
  as.numeric(length(x) > 0)
}

attributes(metric_score.pkg_metric_has_bug_reports_url)$label <-
  "A binary indicator of whether a package links to a location to file bug reports."
