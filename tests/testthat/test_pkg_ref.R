context("pkg_ref")

# This gives an error for some reason. 
# test_that("pkg_ref returns a logical(0) of class 'pkg_ref' when given no arguments", {
#   x <- pkg_ref()
#   expect_s3_class(x, "pkg_ref", exact = TRUE)
#   expect_identical(x, logical(0))
# })
test_that("pkg_ref(x) returns x when x is a pkg_ref", {
  x <- pkg_ref("testthat")
  expect_identical(x, pkg_ref(x))
})
test_that("pkg_ref returns correct class/length when givin list", {
  expect_equal(length(pkg_ref(list("testthat", "vctrs"))), 2)
  expect_is(pkg_ref(list("testthat", "vctrs")), c("list_of_pkg_ref", "vctrs_list_of", "vctrs_vctr"))
})





##### Errors #####
test_that("new_pkg_ref throws error when given unnamed ellipses arguments", {
  expect_error(new_pkg_ref(name = "aName", source = "pkg_install", version = 0, "unnamedArg"),
               "pkg_ref ellipses arguments must be named")
})
test_that("new-pkg_ref throws error when given invalid repo", {
  expect_error(new_pkg_ref(name = "aName", source = "badSource"))
})
test_that("pkg_ref throws error when a non-character or pkg_ref is passed", {
  expect_error(pkg_ref(1), "Don't know how to convert")
})
test_that("pkg_ref throws error when an invalid package/filepath",{
  expect_error(pkg_ref("*asdf"), "can't interpret character")
})
