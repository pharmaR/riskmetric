#' Assess package checks from CRAN/Bioc or R CMD check
#'
#' @eval roxygen_assess_family(
#'   "remote_checks",
#'   "Tally of R CMD check results run on differnt OS flavors by BioC or CRAN",
#'   dontrun = TRUE)
#'
#' @export
assess_remote_checks <- function(x, ...) {
  UseMethod("assess_remote_checks")
}
attr(assess_remote_checks, "column_name") <- "remote_checks"
attributes(assess_remote_checks)$label <- "Number of OS flavors that passed/warned/errored on R CMD check"

#' @export
assess_remote_checks.default <- function(x, ...) {
  as_pkg_metric_na(pkg_metric(class="pkg_metric_remote_checks",
                              message="Package is not a CRAN or BioC reference so there
                              are no CRAN/BioC checks to assess"))
}

#' @export
assess_remote_checks.pkg_cran_remote <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_remote_checks",{
    table(factor(x$remote_checks[["Status"]],
                 levels = c("OK","WARN","ERROR", "NOTE", "FAIL")))
             })
}

#' @export
assess_remote_checks.pkg_bioc_remote <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_remote_checks", {
    table(factor(x$remote_checks[["CHECK"]],
                 levels=c("OK","WARNINGS","ERROR","TIMEOUT")))
             })
}

#' Score a package based on R CMD check results run by BioC or CRAN
#'
#' The scoring function is the number of OS flavors that passed with OK or NOTES + 0.5*the number of OS's that produced WARNINGS divided by the number of OS's checked
#' @eval roxygen_score_family("remote_checks", dontrun = TRUE)
#' @return a fractional value indicating percentage OS flavors that did not produce an error or warning from R CMD check
#'
#' @export
metric_score.pkg_metric_remote_checks <- function(x, ...) {
  unname((x["OK"] + (x[grepl("NOTE", names(x))] *0.75) + (x[grepl("WARN", names(x))] *0.5))/sum(x))
}
attributes(metric_score.pkg_metric_remote_checks)$label <-
  "Weighted sum of OS flavor R CMD check results"
