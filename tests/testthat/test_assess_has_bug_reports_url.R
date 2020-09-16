test_that("assess_has_bug_reports_url returns the correct url", {
  expect_is(
    assess_source_good$has_bug_reports_url,
    c("pkg_metric_has_bug_reports_url", "pkg_metric", "character"))

  expect_match(
    assess_source_good$has_bug_reports_url,
    "https://fake.url.com/pkgsourcegood")
})
