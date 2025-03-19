#' @describeIn riskmetric_metadata_caching
#' Cache a character vector mapping exported values to documentation filenames
#'
#' @family package reference cache
#' @keywords internal
#'
#' @usage NULL
#' @export
pkg_ref_cache.help_aliases <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.help_aliases")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.help_aliases pkg_install
pkg_ref_cache.help_aliases.pkg_install <- function(x, name, ...) {
  readRDS(file.path(x$path, "help", "aliases.rds"))
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.help_aliases pkg_source
pkg_ref_cache.help_aliases.pkg_source <- function (x, name, ...) {
  f <- list.files(file.path(x$path, "man"), full.names = TRUE)
  f <- f[grep("\\.Rd$", f)]
  aliases <- lapply(f, function(i) {
                      rd <- readLines(i)
                      a <- gsub("\\}", "", gsub("\\\\alias\\{", "",
                                                rd [grep("^\\\\alias", rd)]))
                      man_name <- strsplit (strsplit (i, "\\/man\\/") [[1]] [2],
                                            "\\.Rd") [[1]]
                      man_name <- rep (man_name, length (a))
                      names (man_name) <- a
                      return (man_name)    })
  # !duplicated because unique removes names
  unlist(aliases)
}
