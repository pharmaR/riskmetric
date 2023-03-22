test_that("pkg_ref_cache_downloads returns expected result for source package", {
  expect_type(pkg_ref_source_good$downloads, "list")
  testthat::expect_length(pkg_ref_source_good$downloads, 3)
  testthat::expect_named(
    pkg_ref_source_good$downloads,
    c("date", "count", "package")
  )
  testthat::expect_true(
    as.character(sort(pkg_ref_source_good$downloads$date)[[1]]) %in%
    c("2012-10-01", Sys.Date())
  )
})
