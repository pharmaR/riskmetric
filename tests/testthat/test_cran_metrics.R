context("Test CRAN related metrics")

test_that("CRAN current version returns correct format", {

    expect_equal(
      grep(
        "[0-9]+.[0-9]+.[0-9]+(.[0-9]+)*",
        get_cran_version("dplyr")
      ),
      1
    )

    expect_equal(
      grep(
        "[0-9]+.[0-9]+.[0-9]+(.[0-9]+)*",
        get_cran_version("tidyverse")
      ),
      1
    )

})
