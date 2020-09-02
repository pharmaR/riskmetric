test_source_1 <- pkg_ref("./test_package_1")
assess_source_1 <- pkg_assess(test_source_1)
test_source_2 <- pkg_ref("./test_package_2")
assess_source_2 <- pkg_assess(test_source_2)

test_that("assess_news_current returns expected result for source packages", {
  # TODO: Add other pkg_ref types
  expect_true(assess_source_1$news_current[[1]])
  expect_length(assess_source_2$news_current[[1]], 0)
})
