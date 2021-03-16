#' Cache package's Maintainer
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @noRd
pkg_ref_cache.maintainer <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.maintainer")
}



pkg_ref_cache.maintainer.pkg_remote <- function(x, name, ...) {
  maintainer_xpath <- "//td[.='Maintainer:']/following::td[1]"
  maintainer <- xml2::xml_text(xml2::xml_find_all(x$web_html, maintainer_xpath))
  maintainer
}



pkg_ref_cache.maintainer.pkg_install <- function(x, name, ...) {
  if ("Maintainer" %in% colnames(x$description))
    return(x$description[,"Maintainer"])

  a   <- if ("Author" %in% colnames(x$description)) x$description[,"Author"] else NA
  a_r <- if ("Authors@R" %in% colnames(x$description)) x$description[,"Authors@R"] else NA

  if (!is.na(a_r)) {
    a_r_exp <- parse(text = a_r)
    if (all(all.names(a_r_exp, unique = TRUE) %in% c("c", "person"))) {
      return(grep("cre", eval(a_r_exp), value = TRUE))
    }
  } else if (!is.na(a)) {
    return(trimws(strsplit(a, ","))[[1]])
  }

  NA
}



pkg_ref_cache.maintainer.pkg_source <- pkg_ref_cache.maintainer.pkg_install
