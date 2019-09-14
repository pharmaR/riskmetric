#' A helper function for retrieving a list of available fields, identified based
#' on implementation of a pkg_ref_cache method for a given class.
#'
#' @param x a package reference object
#' @return a list of available fields implemented with a pkg_ref_cache method
#'
#' @importFrom utils .S3methods
available_pkg_ref_fields <- function(x) {
  fs <- c(names(getNamespace(packageName())), utils::.S3methods("pkg_ref_cache"))
  f_re <- paste0("^pkg_ref_cache\\.([^.]+)\\.(", paste0(class(x), collapse = "|"), ")")
  fs <- grep(f_re, fs, value = TRUE)
  names(fs) <- fs
  fs <- gsub(f_re, "\\1", fs)
  fs <- fs[order(fs)]
  fs
}



#' S3 function to extend a package reference with new fields
#'
#' @param x a package reference object
#' @param name the name of the field that needs to be cached
#' @param ... additional arguments used for computing cached values
#' @param .class a class name to use for S3 dispatch, defaulting to the name as
#'   a character value
#'
#' @return a value to assign to the new field in the package reference object
#'   environment
#'
#' @family package reference cache
#'
pkg_ref_cache <- function(x, name, ..., .class = as.character(name)) {
  UseMethod("pkg_ref_cache", structure(list(), class = .class))
}
