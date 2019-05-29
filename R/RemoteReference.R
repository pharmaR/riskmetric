#' @import remotes
#' @export
RemoteReference <- function(x, type, version = "latest",
                            repos = list(CRAN = "https://cloud.r-project.org")) {

  type <- match.arg(
    type,
    c("cran", "github"),
    several.ok = FALSE
  )

  if (type == "cran")
    ref <- remotes:::cran_remote(x, repos = repos, type = "source")

  if (type == "github")
    ref <- remotes:::github_remote(x, type = "source")

  ref$version <- version
  ref_class   <- c("RemoteReference", class(ref), "environment")
  ref         <- as.environment(ref)
  class(ref)  <- ref_class

  return(ref)

}

#' @export
download_pkg_sources <- function(remote_ref, dest, ...)
  UseMethod("download_pkg_sources")


#' @import remotes rvest magrittr
#' @export
download_pkg_sources.cran_remote <- function(remote_ref, dest, unpack = FALSE,
                                             method = "auto", ...) {

  url_suffix_newest <- xml2::read_html(sprintf("%s/src/contrib/", remote_ref$repos[[1]])) %>%
    rvest::html_nodes("a") %>%
    rvest::html_attr("href") %>%
    grep(sprintf("^%s_.+.tar.gz$", remote_ref$name), ., value = TRUE)

  if (remote_ref$version == "latest") {
    url_suffix <- url_suffix_newest
  } else {
    # handle case where lastest is given explicitly
    if (remote_ref$version == stringr::str_extract(url_suffix_newest, "(?<=_).+(?=.tar.gz)"))
      url_suffix <- url_suffix_newest
    url_suffix <- sprintf("Archive/%s/%s_%s.tar.gz", remote_ref$name,
                          remote_ref$name, remote_ref$version)
  }

  url_pkg_sources <- sprintf("%s/src/contrib/%s", remote_ref$repos, url_suffix)
  dir.create(dest, recursive = TRUE, showWarnings = FALSE)
  outfile <- sprintf("%s/%s", normalizePath(dest),
                     stringr::str_extract(url_pkg_sources,
                                          sprintf("(?<=/)%s_.+\\.tar\\.gz",
                                                  remote_ref$name)))
  download.file(url_pkg_sources, outfile, method = method, ...)
  remote_ref$local_sources <- outfile
  remote_ref$tmplib        <- dirname(outfile)
  if (unpack) {
    untar(outfile, files = remote_ref$name, exdir = dirname(outfile))
  }

}



#' @import stringr
#' @importFrom httr GET content
#' @export
download_pkg_sources.github_remote <- function(remote_ref, dest, unpack = FALSE,
                                               method = "auto", ...) {

  # resolve version: release (TODO: support tags)
  if (remote_ref$version == "latest") {
    url <- sprintf(
      "https://api.github.com/repos/%s/%s/releases/%s",
      remote_ref$username, remote_ref$repo, remote_ref$version)
  } else {
    url <- sprintf(
      "https://api.github.com/repos/%s/%s/releases/tags/%s",
      remote_ref$username, remote_ref$repo, remote_ref$version)
  }
  response <- httr::content(httr::GET(url), as = "parsed",
                            type = "application/json")

  url_pkg_sources <- response$tarball_url
  dir.create(dest, recursive = TRUE, showWarnings = FALSE)
  version_tag <- basename(url_pkg_sources)
  outfile     <- sprintf("%s/%s_%s.tar.gz", normalizePath(dest), remote_ref$repo,
                         version_tag)
  download.file(url_pkg_sources, outfile, method = method, ...)
  # need to get rid of intermedate dir in GH return .tar.gz
  ext_name    <- untar(outfile, exdir = dirname(outfile), list = TRUE)[1]
  pkg_dirname <- stringr::str_extract(outfile, sprintf(".+/%s", remote_ref$repo))
  untar(outfile, exdir = dirname(outfile))
  file.rename(sprintf("%s/%s", dirname(outfile), ext_name), pkg_dirname)
  unlink(outfile)
  oldwd <- setwd(pkg_dirname)
  tar(tarfile = outfile, files = list.files(), tar = "tar")
  setwd(oldwd)
  remote_ref$local_sources <- outfile
  remote_ref$tmplib        <- dirname(outfile)
  remote_ref$name          <- remote_ref$repo
  if (!unpack) {
    unlink(pkg_dirname, recursive = TRUE)
  }

}
