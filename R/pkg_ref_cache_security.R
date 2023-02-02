#' Run R CMD check and capture the results
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.security <- function (x, ...)
{
  UseMethod("pkg_ref_cache.security")
}

pkg_ref_cache.security.default <- function (x, ...) {
  return(NA)
}

#' Check if oyster
#'
#' @inheritParams pkg_ref_cache
#' @importFrom oysteR audit
#' @return a \code{pkg_ref} object
pkg_ref_cache.security.pkg_source <- function(x, ...){

  # TODO
  scan_results <- oysteR::audit(
    pkg = "name",
    version = "vers", # will this need to be pkg_ref class specific?
    type = "cran", # will this need to be pkg_ref class specific?
    verbose = FALSE
    )

  return(scan_results[["no_of_vulnerabilities"]] )
}
