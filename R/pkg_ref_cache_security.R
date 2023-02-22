#' Cache OSS Index results
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.security <- function(x, ...) {
  UseMethod("pkg_ref_cache.security")
}

#' Check OSS Index lists any vulnerabilities for the package and it's
#' dependencies
#'
#' @inheritParams pkg_ref_cache
#' @return a \code{pkg_ref} object
pkg_ref_cache.security.default <- function(x, ...) {
  scan_results <- oysteR::audit(
    pkg = x$name,
    version = x$version,
    type = "cran",
    verbose = FALSE
  )

  return(sum(scan_results[["no_of_vulnerabilities"]]))
}
