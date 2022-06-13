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
