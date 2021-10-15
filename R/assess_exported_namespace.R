#' Assess a package's results from running R CMD check
#'
#' @eval roxygen_assess_family(
#'   "exported_namespace",
#'   "List of functions and objects exported by a package, excluding S3methods",
#'   dontrun = TRUE)
#'
#' @importFrom pkgload parse_ns_file
#' @export
assess_exported_namespace <- function(x, ...) {
  UseMethod("assess_exported_namespace")
}

attributes(assess_exported_namespace)$column_name <- "exported_namespace"
attributes(assess_exported_namespace)$label <- "Objects exported by package"

#' @export
assess_exported_namespace.default <- function(x, ...) {
  as_pkg_metric_na(
    pkg_metric(class = "pkg_metric_export_help"),
    message = sprintf("Cannot export namespace from a %s", x$source))
}

#' @export
assess_exported_namespace.pkg_install <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_exported_namespace", {
    # ignore S3-dispatched methods
    return(getNamespaceExports(x$name))
  })
}

#' @export
assess_exported_namespace.pkg_source <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_exported_namespace", {
    # ignore S3-dispatched methods
    return(pkgload::parse_ns_file(x$path)$exports)
  })
}

#' Score a package for the number of exported objects
#'
#' Count the number of exported objects (excluding S3Methods) and divide by 100
#'
#' @eval roxygen_score_family("exported_namespace")
#' @return numeric value
#'
#' @export
metric_score.pkg_metric_exported_namespace <- function(x, ...) {
  length(x)
}

attributes(metric_score.pkg_metric_exported_namespace)$label <-
  "The number of exported objects in a package"


