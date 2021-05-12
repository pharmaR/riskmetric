#' Cache a packages exported namespace
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.exported_namespace <- function (x, ...)
{
  UseMethod("pkg_ref_cache.exported_namesapce")
}

pkg_ref_cache.exported_namespace.default <- function (x, ...) {
  return(NA)
}

#' Run R CMD check and capture the results
#'
#' @inheritParams pkg_ref_cache
#' @importFrom devtools check
#' @return a \code{pkg_ref} object
pkg_ref_cache.exported_namespace.pkg_install <- function(x, ...){
  return(getNamespaceExports(x))
}

pkg_ref_cache.exported_namespace.pkg_source <- function(x, ...){
  return(pkgload::parse_ns_file()$exports)
}

