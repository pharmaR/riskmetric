# taken from https://github.com/ropenscilabs/packagemetrics/blob/master/R/get_cran.R
memoise_cran_db <- memoise::memoise({
  function() {
    cran <- tools::CRAN_package_db()
    # remove first instance of column name MD5Sum
    cran <- cran[, -dplyr::first(which(names(cran) == "MD5sum"))]

    # make it a tibble
    cran <- dplyr::tbl_df(cran)

    if (packageVersion("janitor") > "0.3.1") {
      cran <- cran %>%
        janitor::clean_names(case = "old_janitor") %>%
        janitor::remove_empty("cols")
    } else {
      cran <- cran %>%
        janitor::clean_names() %>%
        janitor::remove_empty_cols()
    }
    cran
  }}
)



#' Fetch CRAN Mirrors Info
#'
#' @param all default \code{TRUE}, passed to \code{\link{utils}[getCRANmirrors]}
#' @param host_exists whether cran can be contacted
#' @param ... additional arguments passed to \code{\link{utils}[getCRANmirrors]}
#'
#' @importFrom curl nslookup
memoise_cran_mirrors <- memoise::memoise({
  # add parameter such that memoised results rerun if internet availability changes
  # NOTE: might need to implement actual caching to avoid inconsistent behavior
  # when run with spotty internet
  function(all = TRUE, ...,
    host_exists = !is.null(curl::nslookup("cran.r-project.org", error = FALSE))) {

    tryCatch({
      utils::getCRANmirrors(all = all, ...)
    }, error = function(e) {
      NULL
    })
  }
})



#' @importFrom BiocManager available
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
#' @param host_exists whether bioconductor can be contacted
#'
#' @importFrom curl nslookup
#'
memoise_bioc_mirrors <- memoise::memoise({
  # add parameter such that memoised results rerun if internet availability changes
  # NOTE: might need to implement actual caching to avoid inconsistent behavior
  # when run with spotty internet
  function(host_exists = !is.null(curl::nslookup("bioconductor.org", error = FALSE))) {
    tryCatch({
      read.csv("https://bioconductor.org/BioC_mirrors.csv")
    }, error = function(e) {
      NULL
    })
  }
})



memoise_installed_packages <- memoise::memoise({
  function(...) utils::installed.packages(...)
})



memoise_available_packages <- memoise::memoise({
  function(..., repos = getOption("repos")) {
    if (is.null(repos))
      return(utils::available.packages(NULL))
    else if ("@CRAN@" %in% repos)
      repos[repos == "@CRAN@"] <- "https://cran.rstudio.com/"
    utils::available.packages(repos = repos, ...)
  }
})
