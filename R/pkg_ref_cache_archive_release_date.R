#' Cache a List of Archived Package Release Date from a Package Reference
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
pkg_ref_cache.archive_release_dates <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.archive_release_dates")
}

pkg_ref_cache.archive_release_dates.pkg_cran_remote <- function(x, name, ...) {

  url <- sprintf("%s/src/contrib/Archive/%s", x$repo_base_url, x$name)

  html <- httr::content(httr::GET(url))
  node <- xml2::xml_find_first(html, "//pre")

  text <- unlist(strsplit(xml2::xml_text(node), "\n"))
  db   <- do.call(rbind, strsplit(text[-1], "\\s+"))
  version <- gsub(paste0(x$name, "_(.*)\\.tar\\.gz"), "\\1", db[,2])
  date  <- db[,3]
  cbind(name = x$name, version, date)

}
