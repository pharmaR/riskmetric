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



pkg_ref_cache.release_date.pkg_source <- pkg_ref_cache.release_date.pkg_install
  colnames(x$description) <- tolower(colnames(x$description))
  if (!"date" %in% colnames(x$description)){
    return(NA)
  }else{
    return(x$description[, "date"])
  }
}
