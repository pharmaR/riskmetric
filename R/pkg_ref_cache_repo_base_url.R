pkg_ref_cache.repo_base_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.repo_base_url")
}

pkg_ref_cache.repo_base_url.pkg_remote <- function(x, name, ...) {
  x$repo_base_url <- gsub("/src/contrib$", "", x$repo)
}
