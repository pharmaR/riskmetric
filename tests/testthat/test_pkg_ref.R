options(repos = "fake-cran.fake-r-project.org")

test_that("get_pkg_ref_classes appropriately captures full class chain", {
  skip_on_cran()

  abstract_hierarchy <- list("a" = list("b", "c" = list("d")))
  expect_equal(get_pkg_ref_classes("b", abstract_hierarchy), c("b", "a"))
  expect_equal(get_pkg_ref_classes("d", abstract_hierarchy), c("d", "c", "a"))

  expect_equal(
    get_pkg_ref_classes("pkg_cran_remote"),
    c("pkg_cran_remote", "pkg_remote", "pkg_ref")
  )
})

test_that("pkg_ref infers source when not explicitly provided", {
  skip_on_cran()
  # pkg_source
  ref4 <- pkg_ref_source_bad
  expect_s3_class(ref4, c("pkg_source", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref4$source, "pkg_source")

  # pkg_install
  ref1 <- pkg_ref_install_good
  expect_s3_class(ref1, c("pkg_install", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref1$source, "pkg_install")

  # pkg_cran_remote
  ref2 <- pkg_cran("pkgcranremotegood")
  expect_s3_class(ref2, c("pkg_cran_remote", "pkg_remote", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref2$source, "pkg_cran_remote")

  # pkg_bioc_remote
  # TODO: add bioconductor available packages mock and replace with a stub package
  ref3 <- pkg_bioc("GenomicFeatures")
  expect_s3_class(ref3, c("pkg_bioc_remote", "pkg_remote", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref3$source, "pkg_bioc_remote")
})

test_that("pkg_ref can accept an argument of 'source'", {
  skip_on_cran()
  # argument pkg_cran_remote
  ref5 <- pkg_ref("pkgcranremotegood", source = "pkg_cran_remote")
  expect_s3_class(ref5, c("pkg_cran_remote", "pkg_remote", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref5$source, "pkg_cran_remote")

  # Multiple pkg_refs
  ref6 <- pkg_ref(c("pkgcranremotegood", "pkgcranremotebad"), source = "pkg_cran_remote")
  expect_s3_class(ref6[[1L]], c("pkg_cran_remote", "pkg_remote", "pkg_ref", "environment"), exact = TRUE)
  expect_s3_class(ref6[[2L]], c("pkg_cran_remote", "pkg_remote", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(sapply(ref6, `[[`, "source"), c("pkg_cran_remote", "pkg_cran_remote"))

  # Multiple pkg_refs with different sources
  ref7 <- pkg_ref(c("urltools", "pkgcranremotegood"), source = c("pkg_install", "pkg_cran_remote"))
  expect_s3_class(ref7[[1L]], c("pkg_install", "pkg_ref", "environment"), exact = TRUE)
  expect_s3_class(ref7[[2L]], c("pkg_cran_remote", "pkg_remote", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(sapply(ref7, `[[`, "source"), c("pkg_install", "pkg_cran_remote"))
})

test_that("pkg_ref throws nice warnings when you give bad 'source' arguments",{
  skip_on_cran()
  expect_warning(
    p1 <- pkg_ref("UnknownCRANPkg", source = "pkg_cran_remote"),
    "Package: `UnknownCRANPkg` not found on CRAN, source is now 'pkg_missing'"
  )

  expect_equal(p1$source, "pkg_missing")

  expect_warning(
    p2 <- pkg_ref("UnknownBiocPkg", source = "pkg_bioc_remote"),
    "Package: `UnknownBiocPkg` not found on bioconductor, source is now 'pkg_missing'"
  )
  expect_equal(p2$source, "pkg_missing")

  expect_warning(
    p3 <- pkg_ref("./MissingPackage", source = "pkg_source"),
    "Package source: `./MissingPackage` does not exist, source is now 'pkg_missing'"
  )
  expect_equal(p3$source, "pkg_missing")
})

test_that("pkg_ref throws errors as expected", {
  skip_on_cran()

  expect_error(
    new_pkg_ref("dplyr",
                source = "pkg_cran_remote",
                version = "1.0.0",
                "someUnnamedArgument"),
    "pkg_ref ellipses arguments must be named"
    )
  expect_error(
    pkg_ref(structure(list("abc"), class = "badClass")),
    "Don't know how to convert object class 'badClass' to class 'pkg_ref'"
  )

})

test_that("pkg_ref will return the same object if passed an object of class pkg_ref", {
  skip_on_cran()

  ref1 <- pkg_ref("tools")

  expect_equal(ref1, pkg_ref(ref1))

})

test_that("determine_pkg_source returns the expected values", {
  skip_on_cran()
  ## pkg_source
  expect_equal(
    determine_pkg_source(file.path(test_path(), "test_packages", "pkgsourcegood"),
                         repos = getOption("repos")),
    "pkg_source"
    )

  ## pkg_install
  expect_equal(
    determine_pkg_source("tools", repos = getOption("repos")),
    "pkg_install"
  )

  ## pkg_cran_remote
  expect_equal(
    determine_pkg_source("pkgcranremotegood", repos = getOption("repos")),
    "pkg_cran_remote"
  )

})
