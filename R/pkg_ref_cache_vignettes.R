#' Cache a list of Vignettes files from a package reference
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.vignettes <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.vignettes")
}



pkg_ref_cache.vignettes.pkg_remote <- function(x, name, ...) {
  vignettes_from_url(x$web_url)
}


pkg_ref_cache.vignettes.pkg_install <- function(x, name, ...) {
  vignettes_from_dir(system.file(package = x$name))
}



pkg_ref_cache.vignettes.pkg_source <- function(x, name, ...) {
  vignettes_from_dir(x$path)
}



#' Build a list of Vignettes files discovered within a given directory
#'
#' @param path a package directory path expected to contain Vignettes files
#'
#' @return a list of parsed Vignettes files
#'
vignettes_from_dir <- function(path) {
  # accommodate unique vignettes files

  folder <- c(source = "/vignettes", bundle = "/inst/doc", binary = "/doc")
  files <- unlist(lapply(paste0(path, folder), list.files, full.names = TRUE))

  if (!length(files)) return(data.frame())

  file_path = unique(tools::file_path_sans_ext(files))
  filename = basename(file_path)

  res <- data.frame(filename = filename, path = file_path)
  res <- res[tolower(res$filename) != tolower("index"), ]

  res
}

#' Build a list of Vignettes files discovered within a package website
#'
#' @param path a package directory path expected to contain Vignettes files
#'
#' @return a data frame of Vignettes files
#'
vignettes_from_url <- function(url) {

  file_path <- xml2::read_html(url) %>%
    rvest::html_nodes("a") %>%
    rvest::html_attr("href") %>%
    grep("vignettes", x = ., value = TRUE)

  filename <- tools::file_path_sans_ext(basename(file_path))
  file_path <- sprintf("%s/%s", url, file_path)

  res <- data.frame(filename = filename, path = file_path)
  res <- res[tolower(res$filename) != tolower("index"), ]

  res
}
