#' Cache package's Website URL
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.pkg_website <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.pkg_website")
}

pkg_ref_cache.pkg_website.pkg_remote <- function(x, name, ...) {

  db  <- rvest::html_table(x$web_html)[[1]]
  url <- db[grep("URL",db[,1], ignore.case = TRUE) ,2]
  if(length(url) == 0) url <- NA
  url
}

pkg_ref_cache.pkg_website.default <- function(x, name, ...) {
  get_description_field(x$description, "url")
}

get_matrix_columns <- function(mat, colnames){
  colnames(mat) <- tolower(colnames(mat))
  if (! colnames %in% colnames(mat)){
    return(NA)
  }else{
    return(mat[, colnames])
  }
}
