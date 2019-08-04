#' Create a package reference
#'
#' @inherit as_pkg_ref params return
#'
#' @export
pkg_ref <- function(x, ...) {
  if (missing(x)) return(structure(logical(0L), class = "pkg_ref"))
  as_pkg_ref(x, ...)
}



#' @importFrom vctrs new_vctr
new_pkg_ref <- function(name, version = NA_character_, source, ...) {
  dots <- list(...)
  if (length(dots) && is.null(names(dots)) || any(names(dots) == ""))
    stop("pkg_ref ellipses arguments must be named")

  source <- match.arg(
    source,
    c("pkg_remote", "pkg_install", "pkg_source", "pkg_missing"),
    several.ok = FALSE)

  pkg_data <- as.environment(append(list(
    name = name,
    version = version,
    source = source
  ), dots))

  structure(
    pkg_data,
    class = c(source, "pkg_ref", class(pkg_data)))
}



#' Convert into a package object
#'
#' @param x character value representing a package name, path to a package
#'   source directory or a git remote url or a package object
#' @param ... additional arguments passed to class-specific handlers
#'
#' @return a package object
#'
#' @importFrom vctrs new_list_of
#' @export
as_pkg_ref <- function(x, ...) {
  if ((is.list(x) || is.atomic(x)) && length(x) > 1) {
    pkg_ref_list <- Map(as_pkg_ref, x)
    return(vctrs::new_list_of(pkg_ref_list, ptype = pkg_ref(), class = "list_of_pkg_ref"))
  } else {
    UseMethod("as_pkg_ref")
  }
}



#' @export
as_pkg_ref.default <- function(x, ...) {
  stop(sprintf(
    "Don't know how to convert object class '%s' to class 'pkg_ref'",
    paste(class(x), collapse = ", ")))
}



#' @export
as_pkg_ref.pkg_ref <- function(x, ...) {
  x
}



#' @importFrom utils installed.packages available.packages packageVersion
#' @importFrom xml2 read_html
#' @export
as_pkg_ref.character <- function(x, repos = getOption("repos"), ...) {

  ip <- memoise_installed_packages()
  ap <- memoise_available_packages(repos = repos)
  cran_mirrors <- memoise_cran_mirros()
  bioc_mirrors <- memoise_bioc_mirrors()

  # case when only a package name is provided
  #   e.g. 'dplyr'
  # regex from available:::valid_package_name_regexp
  if (grepl("^[[:alpha:]][[:alnum:].]*[[:alnum:]]$", x)) {

    # if locally installed
    if (x %in% ip[,"Package"]) {
      path <- find.package(x)
      version <- utils::packageVersion(x, lib.loc = dirname(path))

      return(new_pkg_ref(x,
        version = version,
        path = path,
        source = "pkg_install"))

    # if available at a provided repo
    } else if (x %in% ap[,"Package"]) {
      info <- ap[ap[,"Package"] == x,,drop = FALSE]

      p <- new_pkg_ref(x,
        version = info[,"Version"],
        repo = info[,"Repository"],
        source = "pkg_remote")

      if (is_url_subpath_of(p$repo_base_url, c(cran_mirrors$URL, "https://cran.rstudio.com/"))) {
        class(p) <- c("pkg_cran_remote", class(p))
        return(p)
      } else if (is_url_subpath_of(p$repo_base_url, bioc_mirrors$URL)) {
        class(p) <- c("pkg_bioc_remote", class(p))
        return(p)
      }
    }

    # if unable to locate a local or remote version of the package
    return(new_pkg_ref(x, source = "pkg_missing"))

  # case when a directory path to source code is provided
  #   e.g. '../dplyr'
  } else if (dir.exists(x) & file.exists(file.path(x, "DESCRIPTION"))) {
    desc <- read.dcf(file.path(x, "DESCRIPTION"))
    name <- unname(desc[,"Package"])

    return(new_pkg_ref(name,
      version = package_version(desc[,"Version"][[1]]),
      path = normalizePath(x),
      source = "pkg_source"))

  } else {
    stop(sprintf("can't interpret character '%s' as a package reference", x))
  }
}
