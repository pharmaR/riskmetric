#' Run R CMD check and capture the results
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

  # TODO: is this the right way to invoke the functionality to get this info?
  deps <- assess_dependencies(x)

  # when will this break? is as_pkg_metric_na?
  dep_names <- sapply(strsplit(deps[["package"]], " "), "[[", 1)

  # is this the best way to get relevant versions?
  bundle_ref <- pkg_ref(c(x$name, dep_names), source = x$source)
  bundle_names <- sapply(bundle_ref, "[[", "name")
  bundle_versions <- sapply(bundle_ref, function(r) as.character(r[["version"]]))

  scan_results <- oysteR::audit(
    pkg = bundle_names,
    version = bundle_versions,
    type = "cran",
    verbose = FALSE
  )

  return(sum(scan_results[["no_of_vulnerabilities"]]))
}
