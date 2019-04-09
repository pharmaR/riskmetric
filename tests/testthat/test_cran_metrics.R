context("Test CRAN related metrics")

test_that("CRAN current version returns correct format", {

    expect_equal(
      grep(
        "\\d+(\\.\\d+){2,3}",
        get_cran_version("dplyr")
      ),
      1
    )

    expect_equal(
      grep(
        "\\d+(\\.\\d+){2,3}",
        get_cran_version("tidyverse")
      ),
      1
    )

})
