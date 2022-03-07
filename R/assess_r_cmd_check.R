#' Assess a package's results from running R CMD check
#'
#' @eval roxygen_assess_family(
#'   "r_cmd_check",
#'   "Tally of errors, warnings and notes from running R CMD check locally",
#'   dontrun = TRUE)

#' @export
assess_r_cmd_check <- function(x, ...) {
  UseMethod("assess_r_cmd_check")
}

attributes(assess_r_cmd_check)$column_name <- "r_cmd_check"
attributes(assess_r_cmd_check)$label <- "Package check results"

#' @export
assess_r_cmd_check.default <- function(x, ...) {
  as_pkg_metric_na(pkg_metric(class = "pkg_metric_r_cmd_check",
                              message = "Source code not available to run R CMD check on."))
}

#' @export
assess_r_cmd_check.pkg_source <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_r_cmd_check", {
    sapply(x$r_cmd_check[c("notes","errors","warnings")], length)
  })
}

#' @export
assess_r_cmd_check.pkg_cran_remote <- function(x, ...) {
  as_pkg_metric_todo(pkg_metric(class = "pkg_metric_r_cmd_check",
                                message = "Assessment of R CMD check on remote
                                pkg refs is not yet implemented but will be in
                                the future"))
}

#' @export
assess_r_cmd_check.pkg_bioc_remote <- function(x, ...) {
  as_pkg_metric_todo(pkg_metric(class = "pkg_metric_r_cmd_check",
                                "Assessment of R CMD check on remote pkg refs
                                is not yet implemented but will be in the future"))
}

#' Score a package based on R CMD check results run locally
#'
#' The scoring function is the weighted sum of notes (0.1), errors (1) and warnings (0.25), with a maximum score of 1 (no errors, notes or warnings)
#' and a minimum score of 0.
#' Essentially, the metric will allow up to 10 notes, 1 error or 4 warnings before returning the lowest score of 0
#' @eval roxygen_score_family("r_cmd_check", dontrun = TRUE)
#' @return A weighted sum of errors and warnings of all tests preformed
#'
#' @export
metric_score.pkg_metric_r_cmd_check <- function(x, ...) {
  1 - min(c(sum(x*c(0.1, 1, 0.25)), 1))
}
attributes(metric_score.pkg_metric_r_cmd_check)$label <-
  "A weighted sum of errors/warnings/notes from R CMD Check"
