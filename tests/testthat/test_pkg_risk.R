test_that("pkg_risk() works", {
  good_pkgs <- pkg_risk(c("utils","methods"))
  expect_s3_class(good_pkgs, "tbl_df")
  expect_s3_class(good_pkgs, "data.frame")
  expect_equal(nrow(good_pkgs), 2)

  just_one_good_pkg <- pkg_risk(c("methods"))
  expect_equal(nrow(just_one_good_pkg), 1)

  one_missing_pkgs <- pkg_risk(c("utils", "doesntexist1"))
  expect_true(one_missing_pkgs$pkg_ref[[1]]$source != "pkg_missing")
  expect_equal(one_missing_pkgs$pkg_ref[[2]]$source, "pkg_missing")
  expect_equal(nrow(one_missing_pkgs), 2)

  # TODO - ensure this edge case works where no valid package(s) get passed
  all_missing_pkgs <- pkg_risk(c("doesntexist1", "doesntexist2"))
  expect_equal(one_missing_pkgs$pkg_ref[[1]]$source, "pkg_missing")
  expect_equal(one_missing_pkgs$pkg_ref[[2]]$source, "pkg_missing")
  expect_equal(nrow(all_missing_pkgs), 2)

  expect_error(pkg_risk(1))
})
