test_source_1 <- pkg_ref("test_package_1")
assess_source_1 <- assess(test_source_1)
test_source_2 <- pkg_ref("test_package_2")
assess_source_2 <- assess(test_source_2)

test_that("assess_export_help returns expected result for source packages", {
  # Commenting these out until this is implemented for sourced packages
#  expect_true(test_source_1$export_help[[1]])
#  expect_false(test_source_2$export_help[[1]])
})
