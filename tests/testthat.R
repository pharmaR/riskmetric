if (requireNamespace("testthat", quietly = TRUE) && requireNamespace("webmockr", quietly = TRUE) && requireNamespace("jsonlite", quietly = TRUE) && requireNamespace("magrittr", quietly = TRUE)  && requireNamespace("withr", quietly = TRUE)) {
  library(testthat)
  library(riskmetric)

  options(repos = "fake-cran.fake-r-project.org")

  test_check("riskmetric")
}
