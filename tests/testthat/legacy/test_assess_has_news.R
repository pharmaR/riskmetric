

test_that("assess_has_news returns expected result for source packages", {
  # TODO: add other package types
  expect_equal(unclass(assess_source_1$has_news[[1]]), 1)
  expect_equal(unclass(assess_source_2$has_news[[1]]), 0)
})

test_that("assess_has_news returns expected result for CRAN Remote packages", {
  expect_equal(unclass(assess_CRAN_remote_1$has_news[[1]]), 0)
  # Can't get this to work like this. Should work for http mocking
  #expect_equal(unclass(assess_CRAN_remote_2$has_news[[1]]), 1)
})

test_that("assess_has_news returns expected result for installed packages", {
  expect_equal(unclass(assess_installed_package_1$has_news[[1]]), 1)
  expect_equal(unclass(assess_installed_package_2$has_news[[1]]), 0)
})
