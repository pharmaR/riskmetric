test_that("CRAN current version returns correct format", {
  expect_match(get_cran_version("dplyr"), "\\d+(\\.\\d+){2,3}")
  expect_match(get_cran_version("tidyverse"), "\\d+(\\.\\d+){2,3}")
})

test_that("CRAN version metric works with character vector input", {
  expect_length(get_cran_version(c("dplyr", "tidyverse")), 2)
})

test_that("CRAN version metric returns NA for missing packages", {
  expect_equal({
    get_cran_version(c("dplyr", "tidyverse", "zxyabczxy"))[[3]]
  }, {
    NA_character_
  })
})
