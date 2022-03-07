test_that("assess_dependencies returns the correct number of dependencies", {
  expect_s3_class(
    assess_source_good$dependencies,
    c("pkg_metric_dependencies", "pkg_metric", "data.frame"))

  expect_equal(
    nrow(assess_source_good$dependencies),
    0)
})

