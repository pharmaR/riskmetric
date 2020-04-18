#' Cache a List of Package Release Date from a Package Reference
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.release_date <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.release_date")
}


pkg_ref_cache.release_date.pkg_remote <- function(x, name, ...) {

  db  <- rvest::html_table(x$web_html)[[1]]
  date <- db[grep("Publish",db[,1], ignore.case = TRUE) ,2]
  date
}


pkg_ref_cache.release_date.pkg_install <- function(x, name, ...) {

  colnames(x$description) <- tolower(colnames(x$description))
  if (!"date" %in% colnames(x$description)){
      return(NA)
    }else{
      return(x$description[, "date"])
    }
}



pkg_ref_cache.release_date.pkg_source <- function(x, name, ...) {
  colnames(x$description) <- tolower(colnames(x$description))
  if (!"date" %in% colnames(x$description)){
    return(NA)
  }else{
    return(x$description[, "date"])
  }
}


#' Cache a List of Archived Package Release Date from a Package Reference
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.archive_release_date <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.archive_release_date")
}

pkg_ref_cache.archive_release_date.pkg_remote <- function(x, name, ...) {

  url <- sprintf("%s/src/contrib/Archive/%s", x$repo_base_url, x$name)

  html <- xml2::read_html(url)
  node <- rvest::html_node(html, "pre")

  text <- unlist(strsplit(rvest::html_text(node), "\n"))
  db   <- do.call(rbind, strsplit(text[-1], "\\s+"))
  version <- stringr::str_extract(db[,2], "[0-9]*.[0-9]*-[0-9]*")
  date  <- db[,3]
  cbind(name = x$name, version, date)

}

