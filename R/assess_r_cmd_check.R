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
  pkg_metric_na(message = "Source code not available to run R CMD check on.")
}

#' @export
assess_r_cmd_check.pkg_source <- function(x, ...) {
  pkg_metric(sapply(x$r_cmd_check[c("notes","errors","warnings")], length), 
             class = "pkg_metric_r_cmd_check")
}

#' @export
assess_r_cmd_check.pkg_cran_remote <- function(x, ...) {
  pkg_metric_todo("Assessment of R CMD check on remote pkg refs is not yet implemented but will be in the future")
}

#' @export
assess_r_cmd_check.pkg_bioc_remote <- function(x, ...) {
  pkg_metric_todo("Assessment of R CMD check on remote pkg refs is not yet implemented but will be in the future")
}

#' Score a package based on R CMD check results run locally
#'
#' The scoring function is 
#' @eval roxygen_score_family("r_cmd_check", dontrun = TRUE)
#' @return A weighted sum of errors and warnings of all tests preformed
#'
#' @export
metric_score.pkg_metric_r_cmd_check <- function(x, ...) {
  sum(x*c(0.1,1,0.5))
}
attributes(metric_score.pkg_metric_r_cmd_check)$label <-
  "A weighted sum of errors/warnings/notes from R CMD Check"