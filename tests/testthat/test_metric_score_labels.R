test_that("scored assessments maintain labels which indicate what the score represents", {
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
    expect_true({
      scores_have_labels <- vapply(
        pkg_scores_i, 
        function(i) !is.null(attr(i, "label")),
        logical(1L))

      all(scores_have_labels)
    })
  }
})
