# Commenting these out until this is implemented for sourced packages
test_that("assess_export_help returns expected result for source packages", {
  expect_true(assess_source_good$export_help[[1]])
  expect_true(assess_install_good$export_help[[1]])
  expect_true(assess_source_bad$export_help[[1]])
  expect_true(assess_stdlibs_install$export_help[[1]][[1]])

  expect_true(is.numeric(score_install_good$export_help))
  expect_true(is.numeric(score_source_bad$export_help))
  expect_true(is.numeric(score_source_good$export_help))
})
