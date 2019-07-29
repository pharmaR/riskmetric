pkg_ref_cache.web_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.web_url")
}

pkg_ref_cache.web_url.pkg_cran_remote <- function(x, name, ...) {
  x$web_url <- sprintf("%s/web/packages/%s", x$repo_base_url, x$name)
}

pkg_ref_cache.web_url.pkg_bioc_remote <- function(x, name, ...) {
  x$web_url <- sprintf("%s/html/%s.html", x$repo_base_url, x$name)
}
