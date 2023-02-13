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
  examples_from_pkg(x$name)
}

pkg_ref_cache.examples.pkg_source <- function(x, name, ...) {
  examples_from_dir(x$path)
}

#' Filter a simple database of Rd objects in a package for files with example fields
#'
#' @param rddb a simple database of Rd object obtained via tools::Rd_db
#'
#' @return a vector of Rd file names that have example fields
#' @keywords internal
filter_rd_db <- function(rddb) {
  n <- names(rddb)
  examples <- lapply(n, function(i) {
    rd <- rddb[[i]]
    a <- gsub("\\}", "",
              gsub("\\\\(examples|example|usage)\\{", "",
                   rd[grep("^\\\\(examples|example|usage)", rd)]
              )
    )
    man_name <- i
    man_name <- rep(man_name, length(a))
    names(man_name) <- a
    return(man_name)
  })
  # !duplicated because unique removes names
  e <- unlist(examples)[!duplicated(unlist(examples))]
  e
}

#' Build logical vector for Rd objects with example or usage fields discovered in a given package
#'
#' @param pkg a package name expected to contain exported objects
#'
#' @return a numeric proportion of documentation files with examples
#' @keywords internal
examples_from_pkg <- function(pkg) {
  f <- tools::Rd_db(package = pkg)
  rd_all <- names(f)
  e <- filter_rd_db(f)
  rd_all %in% e
}

#' Build logical vector for Rd objects with example or usage fields discovered in a given directory
#'
#' @param path a package directory path expected to contain exported objects
#'
#' @return a numeric proportion of documentation files with examples
#' @keywords internal
examples_from_dir <- function(path) {
  f <- tools::Rd_db(dir = path)
  rd_all <- names(f)
  e <- filter_rd_db(f)
  rd_all %in% e
}
