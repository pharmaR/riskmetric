test_that("Test Assessment accessor functions", {
  expect_true(all(sapply(all_assessments(), class)=="function"))
  expect_true(all(sapply(get_assessments("assess_"), class)=="function"))
  expect_warning(get_assessments("This_is_not_an_assess_function"))

  fs <- names(all_assessments())[1:2]

  expect_true(length(get_assessments(fs))==length(fs))
  expect_true(length(get_assessments(fs, invert=TRUE)) == length(all_assessments()) - length(fs))
  expect_true(all(! fs %in% names(get_assessments(fs, invert=TRUE))))
})
