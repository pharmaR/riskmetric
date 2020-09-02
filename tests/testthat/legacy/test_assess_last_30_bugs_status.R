
test_that("assess_last_30_bugs_status returns expected result for source package", {
  # TODO: add other package types
  # This is calling github.com/elimillera/test_package_1/issues

  skip_if(any(class(assess_source_1$bugs_status) == "pkg_metric_error"))
  expect_equivalent(unclass(assess_source_1$bugs_status), c(FALSE, TRUE, FALSE))

  expect_s3_class(assess_source_2$bugs_status, "pkg_metric_error")
})
