
ap <- available.packages(repos = "cloud.r-project.org")
CRAN_webmockr_version <- ap[ap[,"Package"] == "webmockr", "Version"]

test_that("webmockr remote is necessary until v0.7 release.", {
  expect_true({
    length(CRAN_webmockr_version) == 0L ||
    CRAN_webmockr_version < package_version("0.7")
  })
})
