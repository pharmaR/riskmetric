
assess_cran_checks <- function(x, ...) {
  UseMethod("assess_cran_checks")
}
attr(assess_cran_checks, "column_name") <- "cran_checks"

assess_cran_checks.default <- function(x, ...) {
  pkg_metric(warning("Package is not a CRAN reference so there are no CRAN checks to assess"), class = "pkg_metric_cran_checks")
}

assess_cran_checks.pkg_cran_remote <- function(x, ...) {
  pkg_metric(table(x$cran_checks[["Status"]]), class = "pkg_metric_cran_checks")
}

assess_cran_checks.pkg_bioc_remote <- function(x, ...) {
  pkg_metric(table(x$cran_checks[["Status"]]), class = "pkg_metric_cran_checks")
}

assess_cran_checks.pkg_source <- function(x, ...) {
  pkg_metric(sapply(check_results[c("notes","errors","warnings")], length), class = "pkg_metric_cran_checks")
}
