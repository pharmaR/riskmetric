<<<<<<< HEAD:tests/testthat/legacy/test_assess_has_vignettes.R
=======
test_source_1 <- pkg_ref("./test_package_1")
assess_source_1 <- pkg_assess(test_source_1)
test_source_2 <- pkg_ref("./test_package_2")
assess_source_2 <- pkg_assess(test_source_2)
>>>>>>> 317a53d377672b4c41a836066f7c266a7247850e:tests/testthat/test_assess_has_vignettes.R

test_that("assess_has_vignettes returns the expected result for sourced packages", {

  expect_equal(unclass(assess_source_1$has_vignettes[[1]]), 2)
  expect_equal(unclass(assess_source_2$has_vignettes[[1]]), 0)
})
