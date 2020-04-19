#' Cache package's Maintainer
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.maintainer <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.maintainer")
}

pkg_ref_cache.maintainer.pkg_remote <- function(x, name, ...) {

  db  <- rvest::html_table(x$web_html)[[1]]
  maintainer <- db[grep("Maintainer",db[,1], ignore.case = TRUE) ,2]
  maintainer
}

pkg_ref_cache.maintainer.pkg_install <- function(x, name, ...) {

  get_description_field(x$description, "maintainer")

}

pkg_ref_cache.maintainer.pkg_source <- function(x, name, ...) {

  a   <- get_description_field(x$description, c("author"))
  a_r <- get_description_field(x$description, c("authors@r"))

  if(! is.na(a)){
    maintainer <- unlist(strsplit(a, ","))[1]
  }

  if(! is.na(a_r)){
    maintainer <- grep("cre", eval(parse(text = tmp)), value = TRUE)
  }

  maintainer
}
