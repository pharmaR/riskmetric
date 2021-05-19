#' Create a package reference
#'
#' Create a package reference from package name or filepath, producing an object
#' in which package metadata will be collected as risk assessments are
#' performed. Depending on where the package was found - whether it is found as
#' source code, in a local library or from a remote host - an S3 subclass is
#' given to allow for source-specific collection of metadata. See 'Details' for
#' a breakdown of subclasses. Different sources can be specified by passing a
#' subclass as an arguemnt named 'source', see details.
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
#' A source argument can be passed using the `source` argument. This will
#' override the logic that riskmetric does when determining a package source.
#' This can be useful when you are scoring the most recent version present on a
#' repository, or testing a specific library.
#'
#' \itemize{
#' \item{\strong{\code{pkg_ref}}}{ A default class for general metadata
#' collection.
#'   \itemize{
#'   \item{\strong{\code{pkg_source}}}{ A reference to a source code directory.}
#'   \item{\strong{\code{pkg_install}}}{ A reference to a package installation
#'   location in a package library. A specific library can be passed by passing
#'   the path to the library as the parameter `lib.loc`}
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
#' @section Package Cohorts:
#'
#' *Experimental!*
#' Package cohorts are structures to determine the risk of a set of packages.
#' `pkg_library()` can be called to create a object containing the pkg_ref
#' objects of all packages in a system library.
#'
#'
#' @rdname pkg_ref
#' @export
#'
#' @examples
#'
#' # riskmetric will check for installed packages by default
#' ref_1 <- pkg_ref("utils")
#' ref_1$source # returns 'pkg_install'
#'
#' # You can also override this behavior with a source argument
#' ref_2 <- pkg_ref("utils", source = "pkg_cran_remote")
#' ref_2$source # returns 'pkg_cran_remote'
#'
#' # lib.loc can be used to specify a library for pkg_install
#' ref_3 <- pkg_ref("utils", source = "pkg_install", lib.loc = .libPaths()[1])
pkg_ref <- function(x, ...) {
  if (missing(x)) return(structure(logical(0L), class = "pkg_ref"))
  as_pkg_ref(x, ...)
}



#' @importFrom vctrs new_vctr
#' @keywords internal
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


#' @rdname pkg_ref
#'
#' @param lib.loc The path to the R library directory of the installed package.
pkg_install <- function(x, lib.loc = NULL) {
  if(verify_pkg_source(x, "pkg_install") == "pkg_missing") return(pkg_missing(x))

  path <- find.package(x, lib.loc = lib.loc)
  version <- utils::packageVersion(x, lib.loc = dirname(path))

  new_pkg_ref(x,
              version = version,
              path = path,
              source = "pkg_install")
}

#' @rdname pkg_ref
pkg_source <- function(x) {
  desc <- read.dcf(file.path(x, "DESCRIPTION"))
  name <- unname(desc[,"Package"])

  new_pkg_ref(name,
              version = package_version(desc[,"Version"][[1]]),
              path = normalizePath(x),
              source = "pkg_source")
}

#' @rdname pkg_ref
#'
#' @param repos URL of CRAN repository to pull package metadata.
pkg_cran <- function(x, repos = getOption("repos", "https://cran.rstudio.com")) {
  ap <- memoise_available_packages(repos = repos)
  info <- ap[ap[,"Package"] == x,,drop = FALSE]

  new_pkg_ref(x,
              version = info[,"Version"],
              repo = info[,"Repository"],
              source = c("pkg_cran_remote"))
}

#' @rdname pkg_ref
pkg_bioc <- function(x) {
  bp <- memoise_bioc_available()
  info <- bp[bp[,"Package"] == x,,drop = FALSE]

  new_pkg_ref(x,
              version = info[,"Version"],
              repo = "https://bioconductor.org/packages/release/bioc",
              source = c("pkg_bioc_remote"))
}

#' @rdname pkg_ref
pkg_missing <- function(x) {
  new_pkg_ref(x,
              source = c("pkg_missing"))
}

#' @rdname pkg_ref
pkg_library <- function(lib.loc) {
  # Create pkg_cohort object
  cohort <- pkg_cohort()
  for(pkg in list.files(lib.loc, recursive = FALSE, full.names = FALSE)) {
    cohort[[length(cohort)+1]] <- pkg_install(pkg, lib.loc = lib.loc)
  }
  cohort
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
#' @rdname pkg_ref
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
as_pkg_ref.character <- function(x, repos = getOption("repos", "https://cran.rstudio.com"),
                                 source = NULL, lib.loc = NULL, ...) {

  dots <- list(...)

  pkg_source_ <- ifelse(is.null(source),
                        determine_pkg_source(x, source, repos),
                        verify_pkg_source(x, source, repos))

  stopifnot(pkg_source_ %in% c("pkg_install", "pkg_source", "pkg_cran_remote",
                               "pkg_bioc_remote", "pkg_missing"))

  switch(pkg_source_,
         pkg_install = pkg_install(x, lib.loc = lib.loc),
         pkg_source = pkg_source(x),
         pkg_cran_remote = pkg_cran(x, repos = repos),
         pkg_bioc_remote = pkg_bioc(x),
         pkg_missing = pkg_missing(x)
  )
}

#' Determine the intended source of a new package
#'
#' @param x Package name or path to package
#' @param source type of source passed in `pkg_ref`
#' @return one of c('pkg_install', 'pkg_install', 'pkg_cran_remote',
#'   'pkg_bioc_remote', 'pkg_missing')
#' @keywords internal
determine_pkg_source <- function(x, source, repos) {

  if (dir.exists(x) && file.exists(file.path(x, "DESCRIPTION"))) {
    "pkg_source"


    ## Non-source package
  } else if (grepl("^[[:alpha:]][[:alnum:].]*[[:alnum:]]$", x)) {

    ip <- memoise_installed_packages()

    if (x %in% ip[,"Package"]) {
      return("pkg_install")

      # If its not installed. Pull the package to check it
    } else {
      ap <- memoise_available_packages(repos = repos)
      info <- ap[ap[,"Package"] == x,,drop = FALSE]

      p <- new_pkg_ref(x,
                       version = info[,"Version"],
                       repo = info[,"Repository"],
                       source = c("pkg_remote"))
    }

    if(is_available_cran(x, repos, p)){
      "pkg_cran_remote"


    } else if(is_available_bioc(x, p)) {
      "pkg_bioc_remote"

    } else {
      "pkg_missing"
    }

  } else {
    stop(sprintf("can't interpret character '%s' as a package reference", x))
  }
}

#' Verify a pkg_source when one is manually specified by the user
#' @return a string of package source
#' @keywords internal
verify_pkg_source <- function(x, source, repos) {

  switch(source,
         pkg_install = "pkg_install",
         pkg_source = {
           ## Check source pakcage is present if source is "pkg_source"
           if(source == "pkg_source" && !dir.exists(x)){
             warning(paste0(c("Package source: `", x, "` does not exist, source is now 'pkg_missing'")))
             return("pkg_missing")
           }
         },
         pkg_cran_remote = {

           ap <- memoise_available_packages(repos = repos)
           info <- ap[ap[,"Package"] == x,,drop = FALSE]
           p <- new_pkg_ref(x,
                            version = info[,"Version"],
                            repo = info[,"Repository"],
                            source = c("pkg_remote"))

           if(!is_available_cran(x, repos, p)) {
             warning(paste0(c("Package: `", x, "` not found on CRAN, source is now 'pkg_missing'")))
             return("pkg_missing")
           }

         },
         pkg_bioc_remote = {

           ap <- memoise_available_packages(repos = repos)
           info <- ap[ap[,"Package"] == x,,drop = FALSE]
           p <- new_pkg_ref(x,
                            version = info[,"Version"],
                            repo = info[,"Repository"],
                            source = c("pkg_remote"))

           if(!is_available_bioc(x, p)){
             warning(paste0(c("Package: `", x, "` not found on bioconductor, source is now 'pkg_missing'")))
             return("pkg_missing")
           }
         },
         source)

  source
}
