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
    exports <- getNamespaceExports(x$name)

    # add package to the search path
    attachNamespace(x$name)

    # count number of lines for exported function through the mget function
    nloc <- capture.output(mget(exports, envir = as.environment(paste0("package:", x$name))))

    # sum the number of lines and extract the 4 extra lines (function name, bytecode, environment, blank line)
    length(nloc) - 4*length(exports)
  })
}
