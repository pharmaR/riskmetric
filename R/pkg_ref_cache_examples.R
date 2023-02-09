#' Cache the examples available for exported objects for a package reference
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.examples <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.examples")
}

pkg_ref_cache.examples.pkg_install <- function(x, name, ...) {
  examples_from_dir(x)
}

pkg_ref_cache.examples.pkg_source <- function(x, name, ...) {
  examples_from_dir(x)
}

#' Build a List of Examples For Exported Objects Discovered Within a Given Directory
#'
#' @param path a package directory path expected to contain exported objects
#'
#' @return a vector of parsed examples
#' @keywords internal
examples_from_dir <- function(x) {
  f <- list.files(file.path(x$path, "man"), full.names = TRUE)
  f <- f[grep("\\.Rd$", f)]
  examples <- lapply(f, function(i) {
    rd <- readLines(i)
    a <- gsub("\\}", "",
              gsub("\\\\(examples|example|usage)\\{", "",
                   rd[grep("^\\\\(examples|example|usage)", rd)]
              )
    )
    man_name <- strsplit(strsplit(i, "\\/man\\/")[[1]][2],
                          "\\.Rd")[[1]]
    man_name <- rep(man_name, length(a))
    names(man_name) <- a
    return(man_name)
  })
  # !duplicated because unique removes names
  unlist(examples)[!duplicated(unlist(examples))]
}
