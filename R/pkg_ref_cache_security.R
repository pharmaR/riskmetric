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

#' Check OSS Index lists any vulnerabilities for the package
#'
#' @inheritParams pkg_ref_cache
#' @importFrom oysteR audit
#' @return a \code{pkg_ref} object
pkg_ref_cache.security.default <- function(x, ...){

  # TODO: confirm this just be default as oysteR now works on name + version and
  #       those are present for all pkg_ref instances?

  scan_results <- oysteR::audit(
    pkg = x$name,
    version = x$version, # will this need to be pkg_ref class specific?
    type = "cran", # will this need to be pkg_ref class specific?
    verbose = FALSE
    )

  return(scan_results[["no_of_vulnerabilities"]] )
}
