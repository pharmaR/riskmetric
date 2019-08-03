pkg_ref_cache.news <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.news")
}



pkg_ref_cache.news.pkg_remote <- function(x, name, ...) {
  x$news <- lapply(x$news_urls, xml2::read_html)
}



pkg_ref_cache.news.pkg_install <- function(x, name, ...) {
  x$news <- news_from_dir(system.file(package = x$name))
}



pkg_ref_cache.news.pkg_source <- function(x, name, ...) {
  x$news <- news_from_dir(x$path)
}



news_from_dir <- function(path) {
  # accommodate news.Rd, news.md, etc
  files <- list.files(path, pattern = "^NEWS\\.", full.names = TRUE)
  if (!length(files)) return(list())

  content <- rep(list(NULL), length(files))
  names(content) <- files
  valid <- vector(length(files), mode = "logical")

  # attempt to parse all news.* files
  for (i in seq_along(files)) {
    f <- files[[i]]
    tryCatch({
      if (tolower(tools::file_ext(f)) == "rd") {
        content[[i]] <- .tools()$.news_reader_default(f)
      } else if (tolower(tools::file_ext(f)) == "md") {
        # NOTE: should we do validation of markdown format?
        content[[i]] <- readLines(f)
      }
      valid[[i]] <- TRUE
    }, error = function(e) {
      valid[[i]] <- FALSE
    })
  }

  # NOTE: should we test whether news file is up-to-date with latest version?
  content[valid]
}
