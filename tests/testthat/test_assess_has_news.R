test_source_1 <- pkg_ref("test_package_1")
assess_source_1 <- assess(test_source_1)
test_source_2 <- pkg_ref("test_package_2")
assess_source_2 <- assess(test_source_2)

test_that("assess_has_news returns expected result for source packages", {
  # TODO: add other package types
  expect_equal(unclass(assess_source_1$has_news[[1]]), 1)
  expect_equal(unclass(assess_source_2$has_news[[1]]), 0)
})
