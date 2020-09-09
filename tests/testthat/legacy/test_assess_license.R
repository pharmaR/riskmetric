<<<<<<< HEAD:tests/testthat/legacy/test_assess_license.R
=======
test_source_1 <- pkg_ref("./test_package_1")
assess_source_1 <- pkg_assess(test_source_1)
test_source_2 <- pkg_ref("./test_package_2")
assess_source_2 <- pkg_assess(test_source_2)
>>>>>>> 317a53d377672b4c41a836066f7c266a7247850e:tests/testthat/test_assess_license.R

test_that("assess_license returns the expected result for soruced packages", {

  expect_equal(unclass(assess_source_1$license[[1]]), "MIT + file LICENSE")
  expect_equal(unclass(assess_source_2$license[[1]]), "CC BY 2.0")
})
