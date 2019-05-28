#' Convert into a package object
#'
#' @param x character value representing a package name, path to a package
#'   source directory or a git remote url or a package object
#' @param ... additional arguments passed to class-specific handlers
#'
#' @return a package object
#'
#' @export
pkg_reference <- function(x, ...) {
  # called this class "package_meta" as to not conflict with devtools "package"
  UseMethod("pkg_ref")
}



#' @export
pkg_reference.default <- function(x, ...) {
  stop(sprintf(
    "Don't know how to convert object class '%s' to class 'pkg_reference'",
    paste(class(x), collapse = ", ")))
}



#' @export
pkg_reference.pkg_ref <- function(x, ...) {
  x
}



#' @importFrom utils installed.packages available.packages
#' @export
pkg_reference.character <- function(x, repos = getOption("repos"), ...) {
  ip <- utils::installed.packages()
  ap <- utils::available.packages(repos = repos)

  # case when only a package name is provided
  #   e.g. 'dplyr'
  if (grepl("^[[:alpha:]][[:alnum:].]*[[:alnum:]]$", x)) {
    # regex from available:::valid_package_name_regexp

    # if locally installed
    if (x %in% ip[,"Package"]) {
      return(pkg_ref(x, path = find.package(x), "pkg_install"))

    # if available at a provided repo
    } else if (x %in% ap[,"Package"]) {
      info <- ap[ap[,"Package"] == x,]
      repo <- info[,"Repository"]
      url <- sprintf("%s/%s_%s.tar.gz", repo, x, info[,"Version"])
      return(pkg_ref(x, url = url, repo = repo, "pkg_remote"))

    # otherwise, it's valid but unidentified
    } else {
      return(pkg_ref(x, "pkg_missing"))
    }

  # case when a directory path to source code is provided
  #   e.g. '../dplyr'
  } else if (dir.exists(x) & file.exists(file.path(x, "DESCRIPTION"))) {
    desc <- read.dcf(file.path(x, "DESCRIPTION"))
    name <- unname(desc[,"Package"])
    return(pkg_ref(name, path = normalizePath(x), source = "pkg_source"))

  }

  pkg_ref(x, "pkg_missing")
}



pkg_ref <- function(name, source, ...) {
  dots <- list(...)
  if (length(dots) && is.null(names(dots)) || any(names(dots) == ""))
    stop("pkg_ref ellipses arguments must be named")

  source <- match.arg(
    source,
    c("pkg_remote", "pkg_install", "pkg_source", "pkg_missing"),
    several.ok = FALSE)

  pkg_data <- as.environment(append(list(
    name = name,
    source = source
  ), dots))

  structure(pkg_data, class = c(source, "pkg_reference", "environment"))
}
