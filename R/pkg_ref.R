#' Convert into a package object
#'
#' @param x character value representing a package name, path to a package
#'   source directory or a git remote url or a package object
#' @param ... additional arguments passed to class-specific handlers
#'
#' @return a package object
#'
#' @export
as.pkg_ref <- function(x, ...) {
  # called this class "package_meta" as to not conflict with devtools "package"
  UseMethod("as.pkg_ref")
}



#' @export
as.pkg_ref.default <- function(x, ...) {
  stop(sprintf(
    "Don't know how to convert object class '%s' to class 'pkg_ref'",
    paste(class(x), collapse = ", ")))
}



#' @export
as.pkg_ref.pkg_ref <- function(x, ...) {
  x
}



#' @importFrom utils installed.packages available.packages
#' @export
as.pkg_ref.character <- function(x, repos = getOption("repos"), ...) {
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
  source <- match.arg(
    source,
    c("pkg_remote", "pkg_install", "pkg_source", "pkg_missing"),
    several.ok = FALSE)

  pkg_data <- new_pkg_env(name = name, source = source, ...)
  structure(pkg_data, class = c(source, "pkg_ref", "environment"))
}



#' List of variables with which to prepopulate a pkg_ref environment
#'
#' This list of variables is used for validation when using the \code{pkg_ref}
#' \code{$get} and \code{$set} functions. If new fields are required, please add
#' them here so that they can be controlled in a single place.
#'
pkg_env_fields <- function() { list(
  name = NULL,
  source = NULL,
  path = NULL
) }



#' Instantiate a package environment with guardrails for valid variable names
#'
#' @return a package environment with namespace prepopulated with
#'   \code{pkg_env_fields}, including a \code{$get} and \code{$set} method for
#'   retrieving values and modifying values
#'
new_pkg_env <- function(...) {
  pkg_env <- as.environment(pkg_env_fields())

  # namespace-validated shorthand for checking if variable is not NULL
  pkg_env$has <- function(var) {
    if (!exists(var, envir = pkg_env))
      stop(sprintf('"%s" is not a valid package environment variable'))
    !is.null(pkg_env[[var]])
  }

  # build package getter function, validating against variable names
  pkg_env$get <- function(var, default) {
    if (!exists(var, envir = pkg_env))
      stop(sprintf('"%s" is not declared in this package environemnt', var))
    else if (missing(default)) return(pkg_env[[var]])
    else return(default)
  }

  # build package setter function, restricting variable names
  pkg_env$set <- function(..., .dots = list()) {
    dots <- c(list(...), .dots)

    # handle passing of variables as ellipses `x$set(a = 1, b = 2)`
    if (is.null(names(dots)) || any(names(dots) == ""))
      stop('all arguments passed to $set must be named.')

    # iterate through dot args and try to assign them in package namespace
    for (i in seq_along(dots)) {
      var <- names(dots)[[i]]
      val <- dots[[i]]
      if (exists(var, envir = pkg_env)) {
        unlockBinding(var, env = pkg_env)
        assign(var, val, envir = pkg_env)
        lockBinding(var, env = pkg_env)
      } else {
        stop(sprintf('"%s" is not a valid package environment variable', var))
      }
    }
  }

  lockEnvironment(pkg_env)
  pkg_env$set(...)
  pkg_env
}
