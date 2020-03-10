context("assessments")

test_that("assess returns a tibble tibble with one col per assessment", {
  testthat_pkg_ref <- pkg_ref("testthat")
  testthat_assess <- assess(testthat_pkg_ref)
  assessments <- all_assessments()
  expect_is(assess(testthat_assess), c("tbl_df", "tbl", "data.frame"))
  # Add three to the assessments for package name, version, and pkg_ref type
  expect_length(testthat_assess, length(assessments) + 3)
})