#' Cache a character vector mapping exported values to documentation filenames
#'
#' @family package reference cache
#'
pkg_ref_cache.help_aliases <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.help_aliases")
}



pkg_ref_cache.help_aliases.pkg_install <- function(x, name, ...) {
  readRDS(file.path(x$path, "help", "aliases.rds"))
}
