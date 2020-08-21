test_source_1 <- pkg_ref("./test_package_1")
assess_source_1 <- pkg_assess(test_source_1)
test_source_2 <- pkg_ref("./test_package_2")
assess_source_2 <- pkg_assess(test_source_2)

test_that("assess_license returns the expected result for soruced packages", {

  expect_equal(unclass(assess_source_1$license[[1]]), "MIT + file LICENSE")
  expect_equal(unclass(assess_source_2$license[[1]]), "CC BY 2.0")
})
