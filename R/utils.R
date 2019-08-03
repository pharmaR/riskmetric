#' Accessor for tools namespace
#'
#' used internally for
#'   - tools:::.news_reader_default
.tools <- memoise::memoise(function() {
  getNamespace("tools")
})



#' check if a url originates from a list of repo urls
is_url_subpath_of <- function(url, urls) {
  grepl(paste0("(", paste0(gsub("/$", "", urls), collapse = "|"), ")"), url)
}



#' Return a vector of random uninstalled packages
#'
#' @inheritParams sample
#' @return a character vector of random package names
#'
#' @importFrom tools CRAN_package_db
#' @importFrom utils installed.packages
#'
not_installed_packages <- function() {
  installeddb <- utils::installed.packages()
  crandb <- memoise_cran_db()

  installed_packages <- installeddb[,"Package"]
  cran_packages <- crandb[["package"]]

  unname(setdiff(cran_packages, installed_packages))
}



#' Return a vector of random installed packages
#'
#' @inheritParams sample
#' @return a character vector of random package names
#'
#' @importFrom tools CRAN_package_db
#' @importFrom utils installed.packages
#'
installed_packages <- function(...) {
  installeddb <- utils::installed.packages()
  unname(installeddb[,"Package"])
}



#' Evaluate an expression after first removing a range of S3 classes
with_unclassed_to <- function(x, .class = 1:length(class(x)), expr,
    envir = parent.frame()) {

  x_expr <- substitute(x)
  orig_class <- class(x)
  if (is.character(.class)) .class = 1:which(class(x) == .class)

  eval(bquote(class(.(x_expr)) <- class(.(x_expr))[-.(.class)]), envir = envir)
  out <- eval(expr, envir = envir)
  eval(bquote(class(.(x_expr)) <- .(orig_class)), envir = envir)
  out
}
