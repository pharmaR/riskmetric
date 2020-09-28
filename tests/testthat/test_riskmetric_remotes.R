test_that("webmockr GitHub remote dependency has been replaced by CRAN release v0.7 when available", {
  ap <- available.packages(repos = "cloud.r-project.org")
  CRAN_webmockr_version <- ap[ap[,"Package"] == "webmockr", "Version"]
  expect_true(CRAN_webmockr_version < package_version("0.7"))
})
