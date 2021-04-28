#' Run R CMD check and capture the results
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.r_cmd_check <- function (x, ...)
{
  UseMethod("pkg_ref_cache.r_cmd_check")
}

pkg_ref_cache.r_cmd_check.default <- function (x, ...) {
  return(NA)
}

#' Run R CMD check and capture the results
#'
#' @inheritParams pkg_ref_cache
#' @importFrom devtools check
#' @return a \code{pkg_ref} object
pkg_ref_cache.r_cmd_check.pkg_source <- function(x, ...){
  check_results <- devtools::check(x$path, quiet=TRUE)
  return(check_results)
}
