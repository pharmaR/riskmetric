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
#' @noRd
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



#' @importFrom BiocManager available
#' @importFrom memoise memoise
#' @noRd
memoise_bioc_available <- memoise::memoise({
  function() {
    con <- url("https://bioconductor.org/packages/release/bioc/src/contrib/PACKAGES")
    on.exit(close(con))
    as.data.frame(read.dcf(con), stringsAsFactors = FALSE)
  }
})



#' Fetch BioC Mirrors Info
#'
#' taken from utils::chooseBioCmirror
#'
#' @importFrom curl nslookup
#' @importFrom memoise memoise
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
memoise_installed_packages <- memoise::memoise({
  function(...) utils::installed.packages(...)
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
