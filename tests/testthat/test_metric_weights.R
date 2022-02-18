test_that("Test metric weight setting functions", {
  expect_true(all(add_default_weights(assess_source_good)==1))
  weights_bad <- c(this_is_not_a_metric=0)
  expect_warning(set_metric_weight(assess_source_good, weights_bad))
  weights_good <- setNames(0, names(add_default_weights(assess_source_good))[2])
  expect_equal(set_metric_weight(assess_source_good,
                                 weight = weights_good)[names(weights_good)],
               setNames(0, names(weights_good)))

})
