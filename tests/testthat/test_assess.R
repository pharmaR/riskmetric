test_that("pkg_assess on a single pkg_ref returns a vctrs_list_of with one element per assessment", {
  expect_s3_class(assess_source_good, "vctrs_list_of")
  expect_s3_class(assess_source_good, "list")
  expect_length(assess_source_good, length(all_assessments()))
})


test_that("pkg_assess on list of pkg_refs returns a tibble with one col per assessment", {
  expect_s3_class(assess_stdlibs_install, "tbl_df")
  expect_s3_class(assess_stdlibs_install, "data.frame")
  expect_length(assess_stdlibs_install, length(all_assessments()) + 3)
})


test_that("assess returns the correct classes", {
  expect_s3_class(
    assess_source_good$downloads_1yr,
    c("pkg_metric_downloads_1yr", "pkg_metric", "numeric"))

  expect_s3_class(
    assess_source_good$license,
    c("pkg_metric_license", "pkg_metric", "character"))

  expect_s3_class(
    assess_source_good$bugs_status,
    c("pkg_metric_last_30_bugs_status", "pkg_metric", "logical"))

  expect_s3_class(
    assess_source_good$has_news,
    c("pkg_metric_has_news", "pkg_metric", "integer"))

  expect_s3_class(
    assess_source_good$has_vignettes,
    c("pkg_metric_has_vignettes", "pkg_metric", "integer"))

  expect_s3_class(
    assess_source_good$export_help,
    c("pkg_metric_export_help", "pkg_metric", "logical"))

  expect_s3_class(
    assess_source_good$news_current,
    c("pkg_metric_news_current", "pkg_metric", "logical"))

  expect_s3_class(
    assess_source_good$security,
    c("pkg_metric_security", "pkg_metric", "integer"))

  expect_s3_class(
    assess_source_good$has_examples,
    c("pkg_metric_has_examples", "pkg_metric", "integer"))
})

