
test_that("assess_news_current returns expected result for source packages", {
  # TODO: Add other pkg_ref types
  expect_true(assess_source_1$news_current)
  expect_length(assess_source_2$news_current, 0)
})
