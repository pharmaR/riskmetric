test_that("assess_has_bug_reports_url returns the correct url", {
  expect_s3_class(
    assess_source_good$has_bug_reports_url,
    c("pkg_metric_has_bug_reports_url", "pkg_metric", "integer"))

  expect_equal(as.numeric(assess_source_good$has_bug_reports_url), 1)
})
