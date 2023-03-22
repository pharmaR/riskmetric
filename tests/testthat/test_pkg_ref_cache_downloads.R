test_that("pkg_ref_cache_downloads returns expected result for source package", {
  expect_type(pkg_ref_source_good$downloads, "list")
  testthat::expect_length(pkg_ref_source_good$downloads, 3)
  testthat::expect_named(
    pkg_ref_source_good$downloads,
    c("date", "count", "package")
  )
  testthat::expect_equal(
    as.character(pkg_ref_source_good$downloads[[1,1]]),
    "2012-10-01"
  )
})
