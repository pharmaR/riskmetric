#' Assess a package's results from running R CMD check 
#'
#' @export
assess_r_cmd_check <- function(x, ...) {
  UseMethod("assess_r_cmd_check")
}

attributes(assess_r_cmd_check)$column_name <- "r_cmd_check"
attributes(assess_r_cmd_check)$label <- "Package check results"

assess_r_cmd_check.default <- function(x, ...) {
  pkg_metric_na(message = "Source code not available to run R CMD check on.")
}
assess_r_cmd_check.pkg_source <- function(x, ...) {
  pkg_metric(sapply(x$r_cmd_check[c("notes","errors","warnings")], length), 
             class = "pkg_metric_r_cmd_check")
}

assess_r_cmd_check.pkg_cran_remote <- function(x, ...) {
  pkg_metric_todo("Assessment of R CMD check on remote pkg refs is not yet implemented but will be in the future")
}

assess_r_cmd_check.pkg_bioc_remote <- function(x, ...) {
  pkg_metric_todo("Assessment of R CMD check on remote pkg refs is not yet implemented but will be in the future")
}
