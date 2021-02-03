#' Run R CMD check and capture the results
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.r_cmd_check <- function (x, ...)
{
  UseMethod("pkg_ref_cache.r_cmd_check")
}

pkg_ref_cache.r_cmd_check.default <- function (x, ...) {
  return(NA)
}


#' @importFrom devtools check
pkg_ref_cache.r_cmd_check.pkg_source <- function(x, ...){
  check_results <- devtools::check(x$path, quiet=TRUE)
  return(check_results)
}
