#' Cache the DESCRIPTION file contents for a package reference
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.description <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.description")
}



pkg_ref_cache.description.pkg_install <- function(x, name, ...) {
  read.dcf(file.path(x$path, "DESCRIPTION"))
}



pkg_ref_cache.description.pkg_source <- function(x, name, ...) {
  read.dcf(file.path(x$path, "DESCRIPTION"))
}

usethis::use_package("rvest")  # update DESCRIPTION
#' @importFrom rvest html_nodes html_text
#' @importFrom stats setNames
pkg_ref_cache.description.pkg_cran_remote <- function(x, name, ...) {

  webpage <- httr::content(httr::GET(paste0(x$repo_base_url,"/package=",x$name)),
                           encoding = "UTF-8")

  titlnode <- rvest::html_nodes(webpage, 'h2')
  title    <- rvest::html_text(titlnode)
  title    <- gsub(c("\n |\n|'|\""),"", title)

  descnode <- rvest::html_nodes(webpage, 'p')
  desc     <- rvest::html_text(descnode)[[1]]
  desc     <- gsub(c("\n |\n|'|\""),"", desc)

  td_nodes <- rvest::html_nodes(webpage, 'td')
  td_text  <- rvest::html_text(td_nodes)

  nodnames <- td_text[seq_along(td_text) %% 2 >  0]
  nodnames <- lapply(nodnames, function(x) trimws(x))
  nodnames <- lapply(nodnames, function(x) gsub(":", "", x))
  nodnames <- unlist(nodnames)

  nodvalus <- td_text[seq_along(td_text) %% 2 == 0]
  nodvalus <- lapply(nodvalus, function(x) trimws(x))
  nodvalus <- lapply(nodvalus, function(x) gsub(c("\n|'|\""),"", x))
  nodvalus <- unlist(nodvalus)

  retlist <- as.list(stats::setNames(nodvalus, nodnames))
  retlist[["Title"]] <- title
  retlist[["Description"]] <- desc

  return(retlist)
}
