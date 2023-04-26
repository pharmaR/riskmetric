test_that("assess_has_examples returns expected result for source packages", {
  expect_equal(unclass(assess_source_good$has_examples[[1]]), TRUE)
  expect_equal(unclass(assess_source_bad$has_examples[[1]]), TRUE)
})

test_that("check behavior of package that does not export any objects", {
  expect_length(pkg_ref_source_bad2$examples, 0)
  expect_length(assess_source_bad2$has_examples, 0)
  expect_equal(unclass(score_source_bad2$has_examples[[1]]), NA)
})
