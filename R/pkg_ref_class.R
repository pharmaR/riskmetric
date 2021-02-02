#' Create a package reference
#'
#' Create a package reference from package name or filepath, producing an object
#' in which package metadata will be collected as risk assessments are
#' performed. Depending on where the package was found - whether it is found as
#' source code, in a local library or from a remote host - an S3 subclass is
#' given to allow for source-specific collection of metadata. See 'Details' for
#' a breakdown of subclasses. Different sources can be specified by passing a
#' subclass as an arguemnt named 'source'.
#'
#' Package reference objects are used to collect metadata pertaining to a given
#' package. As data is needed for assessing a package's risk, this metadata
#' populates fields within the package reference object.
#'
#' The \code{pkg_ref} S3 subclasses are used extensively for divergent metadata
#' collection behaviors dependent on where the package was discovered. Because
#' of this, there is a rich hierarchy of subclasses to articulate the different
#' ways package information can be found.
#'
#' \itemize{
#' \item{\strong{\code{pkg_ref}}}{ A default class for general metadata
#' collection.
#'   \itemize{
#'   \item{\strong{\code{pkg_source}}}{ A reference to a source code directory.}
#'   \item{\strong{\code{pkg_install}}}{ A reference to a package installation
#'   location in a package library.}
#'   \item{\strong{\code{pkg_remote}}}{ A reference to package metadata on a
#'   remote server.
#'     \itemize{
#'     \item{\strong{\code{pkg_cran_remote}}}{ A reference to package
#'     information pulled from the CRAN repository.}
#'     \item{\strong{\code{pkg_bioc_remote}}}{ A reference to package
#'     information pulled from the Bioconductor repository.}
#'     \item{\strong{\code{pkg_git_remote}}}{ A reference to a package source
#'     code git repository. (not yet implemented)}
#'     }
#'   }
#'   }
#' }
#' }
#'
#' @inherit as_pkg_ref params return
#'
#'
#'
#' @family pkg_ref
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
    c("pkg_bioc_remote", "pkg_cran_remote", "pkg_remote", "pkg_install", "pkg_source", "pkg_missing"),
    several.ok = TRUE)

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
#' @param x A singular \code{character} value, \code{character vector} or
#'   \code{list} of \code{character} values of package names or source code
#'   directory paths.
#' @param ... Additional arguments passed to methods.
#'
#' @return When a single value is provided, a single \code{pkg_ref} object is
#'   returned, possibly with a subclass based on where the package was found. If
#'   a \code{vector} or \code{list} is provided, a \code{list_of_pkg_ref} object
#'   constructed with \code{\link[vctrs]{list_of}} is returned, which can be
#'   considered analogous to a \code{list}. See 'Details' for further
#'   information about \code{pkg_ref} subclasses.
#'
#' @family pkg_ref
#'
#' @importFrom vctrs new_list_of
#' @export
as_pkg_ref <- function(x, ...) {
  if ((is.list(x) || is.atomic(x)) && length(x) > 1) {

    dots <- list(...)

    # iterate over the list of packages and add sources and versions
    pkg_ref_list <- list()
    for(i in seq_along(x)) {
      if(!is.null(dots$source))
        source <- ifelse(length(dots$source) > 1, dots$source[i], dots$source)
      else source <- NULL

      pkg_ref_list[[i]] <- as_pkg_ref(x[i], source=source)
    }

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
#' @export
as_pkg_ref.character <- function(x, repos = getOption("repos", "https://cran.rstudio.com"), ...) {
  ip <- memoise_installed_packages()

  dots <- list(...)

  # case when only a package name is provided
  #   e.g. 'dplyr'
  # regex from available:::valid_package_name_regexp
  if (grepl("^[[:alpha:]][[:alnum:].]*[[:alnum:]]$", x)) {


    # Check if a 'source' argument was passed, if one was check if its 'pkg_install'
    if ((!is.null(dots$source) && dots$source == "pkg_install") ||
        # If no 'source agrument was passed. check if package is installed.
        (is.null(dots$source) && (x %in% ip[,"Package"]))) {
      path <- find.package(x)
      version <- utils::packageVersion(x, lib.loc = dirname(path))

      return(new_pkg_ref(x,
        version = version,
        path = path,
        source = "pkg_install"))

      # Check if a 'source' argument was passed, if one was check if its of type 'pkg_remote'
    } else if ((!is.null(dots$source) && dots$source %in% c("pkg_remote", "pkg_bioc_remote", "pkg_cran_remote")) ||
               # If no 'source' argument is passed, check if is available at a repo.
               (is.null(dots$source) && x %in% memoise_available_packages(repos = repos)[,"Package"])) {
      ap <- memoise_available_packages(repos = repos)
      info <- ap[ap[,"Package"] == x,,drop = FALSE]

      p <- new_pkg_ref(x,
        version = info[,"Version"],
        repo = info[,"Repository"],
        source = c("pkg_remote"))

      # Check if package is available on CRAN
      if (!is.null(memoise_cran_mirrors()) &&
          # isTRUE added to catch any issues where the cran mirror isn't available
          isTRUE(is_url_subpath_of(
            p$repo_base_url,
            c(memoise_cran_mirrors()$URL, "https://cran.rstudio.com/")))) {

        class(p) <- c("pkg_cran_remote", class(p))
        return(p)

        # Check if package is available on Bioconductor
      }  else if (x %in% memoise_bioc_available()[,"Package"]) {
        bp <- memoise_bioc_available()
        info <- bp[bp[,"Package"] == x,,drop = FALSE]

        return(new_pkg_ref(x,
                           version = info[,"Version"],
                           repo = "https://bioconductor.org/packages/release/bioc",
                           source = c("pkg_remote")))

        # Check Bioconductor mirrors
      } else if (!is.null(memoise_bioc_mirrors()) &&
          isTRUE(is_url_subpath_of(p$repo_base_url, memoise_bioc_mirrors()$URL))) {

        class(p) <- c("pkg_bioc_remote", class(p))
        return(p)

      } else {
        # if unable to locate a local or remote version of the package
        return(new_pkg_ref(x, source = "pkg_missing"))
      }

    }

  # case when a directory path to source code is provided
  #   e.g. '../dplyr'
  } else if ((!is.null(dots$source) && dots$source == "pkg_source") ||
             dir.exists(x) && file.exists(file.path(x, "DESCRIPTION"))) {
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
