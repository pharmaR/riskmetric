test_source_1 <- pkg_ref("test_package_1")
assess_source_1 <- assess(test_source_1)

test_that("assess_last_30_bugs_status returns expected result for source package", {
  # TODO: add other package types
  # This is calling github.com/elimillera/test_package_1/issues
  expect_equal(unclass(assess_source_1$bugs_status[[1]]), c(FALSE, TRUE, FALSE))
})
