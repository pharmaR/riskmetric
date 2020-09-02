
test_that("assess_has_vignettes returns the expected result for sourced packages", {

  expect_equal(unclass(assess_source_1$has_vignettes[[1]]), 2)
  expect_equal(unclass(assess_source_2$has_vignettes[[1]]), 0)
})
