#' Generate list of Reverse Dependencies for a package
#'
#' @details The more packages that depend on a package the more chance
#' for errors/bugs to be found
#'
#' @eval roxygen_assess_family(
#'   "reverse_dependencies",
#'   "A character vector of reverse dependencies")
#'
#' @export
assess_reverse_dependencies <- function(x, ...){
  UseMethod("assess_reverse_dependencies")
}

attr(assess_remote_checks, "column_name") <- "reverse_dependencies"
attributes(assess_remote_checks)$label <- "List of reverse dependencies a package has"

#' @importFrom devtools revdep
#' @export
assess_reverse_dependencies.default <- function(x, ...){
  pkg_metric_eval(class = "pkg_metric_reverse_dependencies",
                  devtools::revdep(x$name, bioconductor = TRUE)
  )
}

#' @importFrom devtools revdep
#' @export
assess_reverse_dependencies.cohort_ref <- function(x, ...){
  cohort_rev_deps <- devtools::revdep(x$cohort$name, bioconductor = TRUE)
  lib_pkgs <- sapply(cohort$library, function(x) x$name)
  pkg_metric_eval(class = "cohort_metric_reverse_dependencies",
                  cohort_rev_deps[cohort_rev_deps %in% lib_pkgs]
  )
}

#' Scoring method for number of reverse dependencies a package has
#'
#' @eval roxygen_score_family("reverse_dependencies", dontrun = TRUE)
#' @return The count of reverse dependencies a package has
#'
#' @export
metric_score.pkg_metric_reverse_dependencies <- function(x,...){
  length(x)
}
