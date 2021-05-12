#' Assess a package's results from running R CMD check
#'
#' @eval roxygen_assess_family(
#'   "r_cmd_check",
#'   "Tally of errors, warnings and notes from running R CMD check locally",
#'   dontrun = TRUE)

#' @export
assess_exported_namespace <- function(x, ...) {
  UseMethod("assess_exported_namespace")
}

attributes(assess_r_cmd_check)$column_name <- "exported_namespace"
attributes(assess_r_cmd_check)$label <- "Objects exported by package"

#' @export
assess_exported_namespace.default <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_exported_namespace", {
    # ignore S3-dispatched methods
    return(length(x$exported_namespaces))
  })
}

