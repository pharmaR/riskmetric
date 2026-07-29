#' Fetch CRAN Mirrors Info
#'
#' @param all default \code{TRUE}, passed to \code{\link{utils}[getCRANmirrors]}
#' @param ... additional arguments passed to \code{\link{utils}[getCRANmirrors]}
#' @param .local an optional local directory to source the CRAN package index
#'   from, defaulting to \code{getOption("riskmetric.tests")}, used
#'   for isolating repository requests during testing.
#'
#' @importFrom curl nslookup
#' @importFrom memoise memoise
#' @return a data frame with mirror information
#' @keywords internal
memoise_cran_mirrors <- memoise::memoise({
  # add parameter such that memoised results rerun if internet availability changes
  # NOTE: might need to implement actual caching to avoid inconsistent behavior
  # when run with spotty internet
  function(all = TRUE, ..., .local = getOption("riskmetric.tests")) {
    if (!is.null(.local)) {
      return(read.csv(
        file.path(.local, "test_webmocks", "data", "cran_mirrors.csv"),
        stringsAsFactors = FALSE))
    }

    tryCatch({
      utils::getCRANmirrors(all = all, ...)
    }, error = function(e) {
      NULL
    })
  }
})



#' Fetch the set of packages available across all Bioconductor repositories
#'
#' Previously only the "BioCsoft" repository
#' (\code{https://bioconductor.org/packages/release/bioc}) was queried, which
#' silently excluded ~1,400 packages hosted in the annotation, experiment,
#' workflow and books repositories for a given Bioconductor release. This
#' function now consults every repository advertised by
#' \code{BiocManager::repositories()} whose name starts with \code{"BioC"}.
#'
#' @param repos a named character vector of Bioconductor repository URLs,
#'   defaulting to the \code{BioC*} entries of \code{BiocManager::repositories()}.
#'   Users pointing at an internal / mirrored Bioconductor can override this by
#'   setting \code{options(repos = ...)} so \code{BiocManager::repositories()}
#'   returns the mirrored URLs.
#' @param ... additional arguments forwarded to \code{utils::available.packages()}.
#' @param .local an optional local directory to source a mocked Bioconductor
#'   package index from, defaulting to \code{getOption("riskmetric.tests")}.
#'   Used for isolating repository requests during testing.
#'
#' @return a data frame with at least \code{Package}, \code{Version} and
#'   \code{Repository} columns, combining the results from every Bioconductor
#'   repository queried. Duplicates (a package appearing in more than one
#'   repository) are resolved to the first occurrence.
#'
#' @importFrom BiocManager repositories
#' @importFrom memoise memoise
#' @keywords internal
memoise_bioc_available <- memoise::memoise({
  function(repos = bioc_repositories(), ...,
           .local = getOption("riskmetric.tests")) {
    if (!is.null(.local)) {
      db <- read.csv(
        file.path(.local, "test_webmocks", "data", "bioc_packages.csv"),
        stringsAsFactors = FALSE)
      if (!"Repository" %in% names(db)) {
        db[["Repository"]] <- paste0(
          "https://bioconductor.org/packages/release/bioc", "/src/contrib")
      }
      return(db)
    }

    if (is.null(repos) || length(repos) == 0L) {
      return(data.frame(
        Package = character(0), Version = character(0),
        Repository = character(0), stringsAsFactors = FALSE))
    }

    ap <- tryCatch(
      utils::available.packages(repos = repos, ...),
      error = function(e) NULL)

    if (is.null(ap) || nrow(ap) == 0L) {
      return(data.frame(
        Package = character(0), Version = character(0),
        Repository = character(0), stringsAsFactors = FALSE))
    }

    df <- as.data.frame(ap, stringsAsFactors = FALSE)
    df[!duplicated(df[["Package"]]), , drop = FALSE]
  }
})


#' Return the set of Bioconductor repository URLs to query
#'
#' Filters \code{BiocManager::repositories()} down to the entries whose names
#' start with \code{"BioC"} - by default \code{BioCsoft}, \code{BioCann},
#' \code{BioCexp}, \code{BioCworkflows} and \code{BioCbooks}. Any non-BioC
#' entries (e.g. \code{CRAN}) are dropped so \code{utils::available.packages()}
#' isn't asked to fold CRAN into the Bioconductor index.
#'
#' @return a named character vector of repository URLs, possibly empty if
#'   \code{BiocManager::repositories()} errors or returns nothing BioC-shaped.
#' @keywords internal
bioc_repositories <- function() {
  repos <- tryCatch(BiocManager::repositories(), error = function(e) NULL)
  if (is.null(repos) || length(repos) == 0L) return(character(0))
  nms <- names(repos)
  if (is.null(nms)) return(character(0))
  repos[startsWith(nms, "BioC")]
}



#' Fetch BioC Mirrors Info
#'
#' taken from utils::chooseBioCmirror
#'
#' @importFrom curl nslookup
#' @importFrom memoise memoise
#' @return a data frame with mirror information
#' @keywords internal
memoise_bioc_mirrors <- memoise::memoise({
  # add parameter such that memoised results rerun if internet availability changes
  # NOTE: might need to implement actual caching to avoid inconsistent behavior
  # when run with spotty internet
  function() {
    tryCatch({
      read.csv("https://bioconductor.org/BioC_mirrors.csv")
    }, error = function(e) {
      NULL
    })
  }
})



#' @importFrom memoise memoise
memoise_available_packages <- memoise::memoise({
  function(..., repos = getOption("repos"), .local = getOption("riskmetric.tests")) {
    if (!is.null(.local)) {
      db <- read.csv(
        file.path(.local, "test_webmocks", "data", "cran_packages.csv"),
        stringsAsFactors = FALSE)
      db[, "Repository"] <- contrib.url(repos, getOption("pkgType"))
      return(db)
    } else if (is.null(repos)) {
      return(utils::available.packages(NULL))
    } else if ("@CRAN@" %in% repos) {
      repos[repos == "@CRAN@"] <- "https://cloud.r-project.org"
    }

    utils::available.packages(repos = repos, ...)
  }
})
