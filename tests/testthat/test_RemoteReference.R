context("Test remote download of source tarballs")



test_that("CRAN version can be downloaded", {
  # TODO: verify that it actually is the newest?
  remote_ref <- RemoteReference("dplyr", "cran", "latest")
  dest       <- tempfile()
  dir.create(dest); on.exit(unlink(dest, recursive = TRUE, force = TRUE))

  download_pkg_sources(remote_ref, dest)
  expect_true(
    list.files(dest) %>% grepl("\\.tar\\.gz$", .) %>% any)

  remote_ref$version <- "0.8.0" # an old one
  download_pkg_sources(remote_ref, dest)
  expect_true(
    list.files(dest) %>% grepl("^dplyr_0\\.8\\.0\\.tar\\.gz$", .) %>% any)

  download_pkg_sources(remote_ref, dest, unpack = TRUE)
  expect_true(
    list.files(dest) %>% grepl("^dplyr$", .) %>% any)

})



test_that("github version can be downloaded", {
  # TODO: verify that it actually is the newest?
  remote_ref <- RemoteReference("tidyverse/dplyr", "github", "latest")
  dest       <- tempfile()
  dir.create(dest); on.exit(unlink(dest, recursive = TRUE, force = TRUE))

  download_pkg_sources(remote_ref, dest)
  expect_true(
    list.files(dest) %>% grepl("\\.tar\\.gz$", .) %>% any)

  remote_ref$version <- "v0.8.0" # an old one
  download_pkg_sources(remote_ref, dest)
  expect_true(
    list.files(dest) %>% grepl("^dplyr_v0\\.8\\.0\\.tar\\.gz$", .) %>% any)

  download_pkg_sources(remote_ref, dest, unpack = TRUE)
  expect_true(
    list.files(dest) %>% grepl("^dplyr$", .) %>% any)

})
