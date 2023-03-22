test_that("pkg_ref_cache_downloads returns expected result for source package", {
  expect_type(pkg_ref_source_good$download, "list")
  testthat::expect_length(pkg_ref_source_good$download, 3)
  testthat::expect_named(
    pkg_ref_source_good$download,
    c("date", "count", "package")
  )
})
