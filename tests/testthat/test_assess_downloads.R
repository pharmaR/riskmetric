test_that("assess_downloads returns expected result for source package", {
  expect_s3_class(
    assess_source_good$downloads_1yr,
    c("pkg_metric_downloads_1yr", "pkg_metric", "integer"))

  expect_type(assess_source_good$downloads_1yr, "double")
  expect_lte(assess_source_good$downloads_1yr, 1)
  expect_gte(assess_source_good$downloads_1yr, 0)
})
