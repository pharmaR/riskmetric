#' Cache value of a package's source repo's URL
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
#' @export
pkg_ref_cache.repo_base_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.repo_base_url")
}


#' @export
#' @method pkg_ref_cache.repo_base_url pkg_remote
pkg_ref_cache.repo_base_url.pkg_remote <- function(x, name, ...) {
  gsub("/src/contrib$", "", x$repo)
}
