test_that("scored assessments are all between [0,1]", {
  pkg_scores_objs <- list(
    # score_cran_remote_good,
    # score_cran_remote_bad,
    score_source_good
    # score_source_bad,
    # score_stdlib_install,
    # score_stdlibs_install,
    # score_pkg_missing
  )
  for (pkg_scores_i in pkg_scores_objs) {
    pkg_metric_idx <- which(sapply(pkg_scores_i, function(x) any(class(x) %in% "pkg_score")))
    expect_true({
      metrics_are_valid <- vapply(pkg_scores_i[pkg_metric_idx],
                                  function(i) all(na.omit(i)<=1 & na.omit(i) >= 0),
                                  logical(1L))

      all(metrics_are_valid)
    })
  }
})
