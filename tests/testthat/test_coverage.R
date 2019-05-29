context("Test coverage computation")



test_that("CRAN version can be downloaded", {

  # TODO: we should have a dedicated test package were we now the coverage exactly x)
  remote_ref <- RemoteReference("dplyr", "cran", "latest")
  dest       <- tempfile()
  dir.create(dest); on.exit(unlink(dest, recursive = TRUE, force = TRUE))

  download_pkg_sources(remote_ref, dest, unpack = TRUE)
  cov_res <- coverage(remote_ref)
  # TODO: still need to figure out what to do with the report
  expect_true(nrow(as.data.frame(cov_res)) > 0)

})
