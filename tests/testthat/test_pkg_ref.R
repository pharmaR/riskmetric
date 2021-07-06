test_that("pkg_ref infers source when not explicitly provided", {
  # pkg_source
  ref4 <- pkg_ref_source_bad
  expect_s3_class(ref4, c("pkg_source", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref4$source, "pkg_source")

  # pkg_install
  ref1 <- pkg_ref("testthat")
  expect_s3_class(ref1, c("pkg_install", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref1$source, "pkg_install")

  # pkg_cran_remote
  ref2 <- pkg_ref("pkgcranremotegood")
  expect_s3_class(ref2, c("pkg_cran_remote", "pkg_remote", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref2$source, "pkg_cran_remote")

  # pkg_bioc_remote
  # TODO: add bioconductor available packages mock and replace with a stub package
  ref3 <- pkg_ref("GenomicFeatures")
  expect_s3_class(ref3, c("pkg_bioc_remote", "pkg_remote", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref3$source, "pkg_bioc_remote")
})

test_that("pkg_ref can accept an argument of 'source'", {
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

  # pkg_install
  ref8 <- pkg_ref_install_good
  expect_s3_class(ref8, c("pkg_install", "pkg_ref", "environment"), exact = TRUE)
  expect_equal(ref8$source, "pkg_install")
})

test_that("pkg_ref throws nice warnings when you give bad 'source' arguments",{
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
