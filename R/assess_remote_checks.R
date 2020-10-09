#' Assess package checks from CRAN/Bioc or R CMD check
#'
#'
#' @export
assess_cran_checks <- function(x, ...) {
  UseMethod("assess_cran_checks")
}
attr(assess_cran_checks, "column_name") <- "cran_checks"

assess_cran_checks.default <- function(x, ...) {
  pkg_metric_na(message="Package is not a CRAN or BioC reference so there are no CRAN/BioC checks to assess")
}

#' @export
assess_cran_checks.pkg_cran_remote <- function(x, ...) {
  pkg_metric(table(factor(x$cran_checks[["Status"]], 
                          levels = c("OK","WARN","ERROR", "NOTE", "FAIL"))), 
             class = "pkg_metric_cran_checks")
}

#' @export
assess_cran_checks.pkg_bioc_remote <- function(x, ...) {
  pkg_metric(table(factor(x$cran_checks[["CHECK"]], 
                          levels=c("OK","WARNINGS","ERROR","TIMEOUT"))), 
             class = "pkg_metric_cran_checks")
}
