#' Cache package's Source Control
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.source_control <- function(x, name, ...) {
  pkg_res_cache.source_control_url(x$pkg_website)
}

pkg_ref_cache.source_control.pkg_remote <- function(x, name, ...) {

  pkg_ref_cache.source_control_url(x$pkg_website)

}

pkg_ref_cache.source_control.pkg_install <- function(x, name, ...) {

  pkg_res_cache.source_control_url(x$pkg_website)

}

pkg_ref_cache.source_control.pkg_source <- function(x, name, ...) {

  pkg_res_cache.source_control_url(x$pkg_website)

}

