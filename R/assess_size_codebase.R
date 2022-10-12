#' Assess a package for size of code base
#'
#' @eval roxygen_assess_family(
#'   "size_codebase",
#'   "a numeric value for number of lines of code base for a package")
#'
#' @export
assess_size_codebase <- function(x, ...) {
  UseMethod("assess_size_codebase")
}

attributes(assess_size_codebase)$column_name <- "size_codebase"
attributes(assess_size_codebase)$label <- "number of lines of code base"

#' @export
assess_size_codebase.default <- function(x, ...) {
  as_pkg_metric_na(
    pkg_metric(class = "pkg_metric_size_codebase"),
    message = sprintf("Cannot compute the number of lines of code from a %s", x$source))
}


#' @export
assess_size_codebase.pkg_install <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_size_codebase", {
    # create character vector of exported function
    exports <- paste0(x$name,"::", getNamespaceExports(x$name))

    # count number of lines in each function through capture.output function
    nloc <- sapply(exports, function(x){length(capture.output(eval(str2lang(x))))})

    # sum the number of lines and extract the 2 extra lines (bytecode, environment)
    sum(nloc) - 2*length(nloc)
  })
}

#' Score a package for number of lines of code
#'
#' Scores packages based on its codebase size, as determined by number of lines of code.
#'
#' @eval roxygen_score_family("size_codebase")
#'
#' @return numeric value between \code{0} (low) and \code{1} (large number of lines of code) converting the number of downloads.
#' @export
metric_score.pkg_metric_size_codebase <- function(x, ...) {
  1.5 / (x / 1e2 + 1.5) - 1
}

attributes(metric_score.pkg_metric_size_codebase)$label <-
  "A logistic rating of the number of lines of code in a package."
