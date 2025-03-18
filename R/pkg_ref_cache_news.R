#' Cache a list of NEWS files from a package reference
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
#' @export
pkg_ref_cache.news <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.news")
}


#' Cache a list of NEWS files from a package reference
#'
#' @importFrom httr content GET
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @export
#' @method pkg_ref_cache.news pkg_remote
pkg_ref_cache.news.pkg_remote <- function(x, name, ...) {
  # default encoding messages suppressed
  suppressMatchingConditions(
    lapply(x$news_urls, function(news_url) {
      response <- httr::GET(news_url)
      httr::content(
        response,
        type = response$headers$`content-type` %||% "text/html")
    }),
    messages = "default")
}

#' @export
#' @method pkg_ref_cache.news pkg_install
pkg_ref_cache.news.pkg_install <- function(x, name, ...) {
  news_from_dir(system.file(package = x$name))
}

#' @export
#' @method pkg_ref_cache.news pkg_source
pkg_ref_cache.news.pkg_source <- function(x, name, ...) {
  news_from_dir(x$path)
}



#' Build a list of NEWS files discovered within a given directory
#'
#' @param path a package directory path expected to contain NEWS files
#'
#' @return a list of parsed NEWS files
#' @keywords internal
news_from_dir <- function(path) {
  # accommodate news.Rd, news.md, etc
  files <- list.files(path, pattern = "^NEWS($|\\.)", full.names = TRUE)
  if (!length(files)) return(list())

  content <- rep(list(NULL), length(files))
  names(content) <- files
  valid <- vector(length(files), mode = "logical")

  # attempt to parse all news.* files
  for (i in seq_along(files)) {
    f <- files[[i]]
    ext <- tolower(tools::file_ext(f))
    tryCatch({
      if (ext == "rd") {
        content[[i]] <- .tools()$.news_reader_default(f)
      } else if (ext == "md" || nchar(ext) == 0L) {
        # NOTE: should we do validation of markdown format?
        content[[i]] <- readLines(f, warn = FALSE)
      }
      valid[[i]] <- TRUE
    }, error = function(e) {
      valid[[i]] <- FALSE
    })
  }

  # NOTE: should we test whether news file is up-to-date with latest version?
  content[valid]
}
