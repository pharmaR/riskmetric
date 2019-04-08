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
