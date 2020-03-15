context("assessments")

pkg_tested <- "testthat"

test_that("assess returns a tibble tibble with one col per assessment", {
  a_pkg_ref <- pkg_ref(pkg_tested)
  a_pkg_assess <- assess(a_pkg_ref)
  assessments <- all_assessments()
  expect_is(assess(a_pkg_assess), c("tbl_df", "tbl", "data.frame"))
  # Add three to the assessments for package name, version, and pkg_ref type
  expect_length(a_pkg_assess, length(assessments) + 3)
})
test_that("assess returns the correct classes", {
  a_pkg_ref <- pkg_ref(pkg_tested)
  a_pkg_assess <- assess(a_pkg_ref)
  expect_is(a_pkg_assess$downloads_1yr[[1]], c("pkg_metric_downloads_1yr", "pkg_metric", "numeric"))
  expect_is(a_pkg_assess$license[[1]], c("pkg_metric_license", "pkg_metric", "character"))
  expect_is(a_pkg_assess$bugs_status[[1]], c("pkg_metric_last_30_bugs_status", "pkg_metric", "logical"))
  expect_is(a_pkg_assess$has_news[[1]], c("pkg_metric_has_news", "pkg_metric", "integer"))
  expect_is(a_pkg_assess$has_vignettes[[1]], c("pkg_metric_has_vignettes", "pkg_metric", "integer"))
  expect_is(a_pkg_assess$export_help[[1]], c("pkg_metric_export_help", "pkg_metric", "logical"))
  expect_is(a_pkg_assess$news_current[[1]], c("pkg_metric_news_current", "pkg_metric", "logical"))
})