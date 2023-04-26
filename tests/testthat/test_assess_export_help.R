# Commenting these out until this is implemented for sourced packages
test_that("assess_export_help returns expected result for source packages", {

  expect_equal(unclass(unname(assess_source_good$export_help)), c(TRUE), ignore_attr = TRUE)
  expect_equal(unclass(unname(assess_install_good$export_help)), c(TRUE), ignore_attr = TRUE)

  expect_equal(unclass(unname(assess_source_bad$export_help)), c(FALSE, TRUE), ignore_attr = TRUE)

  expect_true(assess_stdlibs_install$export_help[[1]][[1]])

  expect_equal(score_install_good$export_help[[1]], 1), ignore_attr = TRUE)
  expect_equal(score_source_bad$export_help[[1]], 0.5, ignore_attr = TRUE)
  expect_equal(score_source_good$export_help[[1]], 1, ignore_attr = TRUE)
})
