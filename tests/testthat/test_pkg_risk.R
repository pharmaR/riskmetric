test_that("pkg_risk() works", {
  good_pkgs <- pkg_risk(c("utils","methods"))
  expect_s3_class(good_pkgs, "tbl_df")
  expect_s3_class(good_pkgs, "data.frame")

  expect_error(pkg_risk(1)
})
