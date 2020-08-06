

test_that("assess_export_help returns expected result for source packages", {
  # TODO: Commenting these out until this is implemented for sourced packages
#  expect_true(test_source_1$export_help[[1]])
#  expect_false(test_source_2$export_help[[1]])
})

test_that("assess_export_help returns expected result for CRAN remote packages", {
  #TODO: Add when this is available for source packages.
})

test_that("assess_export_help returns expected result for installed packages", {
  # TODO: Update this once I figure out HTTP mocking
  expect_s3_class(assess_installed_package_1$export_help, "pkg_metric_export_help")
  expect_s3_class(assess_installed_package_1$export_help, "pkg_metric")
  expect_type(assess_installed_package_1$export_help, "logical")
  expect_named(assess_installed_package_1$export_help)

  expect_s3_class(assess_installed_package_2$export_help, "pkg_metric_export_help")
  expect_s3_class(assess_installed_package_2$export_help, "pkg_metric")
  expect_type(assess_installed_package_2$export_help, "logical")
  expect_named(assess_installed_package_2$export_help)
})
