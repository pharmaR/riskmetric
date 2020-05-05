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

  get_matrix_columns(x$description, "maintainer")

}

pkg_ref_cache.maintainer.pkg_source <- function(x, name, ...) {

  a   <- get_matrix_columns(x$description, c("author"))
  a_r <- get_matrix_columns(x$description, c("authors@r"))

  maintainer <- NA

  if(! is.na(a)){
    maintainer <- unlist(strsplit(a, ","))[1]
  }

  if(! is.na(a_r)){

    a_r_exp <- parse(text = a_r)
    if( all(all.names(a_r_exp, unique = TRUE) %in% c("c", "person") ) ){
      maintainer <- grep("cre", eval(a_r_exp), value = TRUE)
    }

  }

  maintainer
}
