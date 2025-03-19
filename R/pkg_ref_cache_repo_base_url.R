#' @describeIn riskmetric_metadata_caching
#' Cache value of a package's source repo's URL
#'
#' @family package reference cache
#' @keywords internal
#'
#' @usage NULL
#' @export
pkg_ref_cache.repo_base_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.repo_base_url")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.repo_base_url pkg_remote
pkg_ref_cache.repo_base_url.pkg_remote <- function(x, name, ...) {
  gsub("/src/contrib$", "", x$repo)
}
