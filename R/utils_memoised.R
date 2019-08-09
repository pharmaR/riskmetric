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



memoise_cran_mirros <- memoise::memoise({
  function(all = TRUE, ...) utils::getCRANmirrors(all = all, ...)
})



# taken from utils::chooseBioCmirror
memoise_bioc_mirrors <- memoise::memoise({
  function() read.csv("https://bioconductor.org/BioC_mirrors.csv")
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
