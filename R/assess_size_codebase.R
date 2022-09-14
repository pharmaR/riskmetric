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

#' @export
assess_size_codebase.pkg_source <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_size_codebase", {
    # create character vector of function files
    files <- list.files(path = file.path(x$path, "R"), full.names = T)

    # define the function for counting code base
    count_lines <- function(x){
      # read the lines of code into a character vector
      code_base <- readLines(x)

      # count all the lines
      n_tot <- length(code_base)

      # count lines for roxygen headers starting with #
      n_head <- length(grep("^#+", code_base))

      # count the comment lines with leading spaces
      n_comment <- length(grep("^\\s+#+", code_base))

      # count the line breaks or only white space lines
      n_break <- length(grep("^\\s*$", code_base))

      # compute the line of code base
      n_tot - (n_head + n_comment + n_break)
    }

    # count number of lines for all functions
    nloc <- sapply(files, count_lines)

    # sum the number of lines
    sum(nloc)
  })
}


