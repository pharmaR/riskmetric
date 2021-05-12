

test_that("pkg_ref can accept an argument of 'source'", {
  # # Defaults # #
  # pkg_install
  ref1 <- pkg_ref("testthat")
  # pkg_cran_remote
  ref2 <- pkg_ref("coin")
  # pkg_bioc_remote
  ref3 <- pkg_ref("GenomicFeatures")
  # pkg_source
  ref4 <- pkg_ref("./test_packages/pkgsourcebad")
  # argument pkg_cran_remote
  ref5 <- pkg_ref("testthat", source = "pkg_cran_remote")
  # Multiple pkg_refs
  ref6 <- pkg_ref(c("urltools", "curl"), source = "pkg_cran_remote")
  # Multiple pkg_refs with different sources
  ref7 <- pkg_ref(c("urltools", "curl"), source = c("pkg_install",
                                                    "pkg_cran_remote"))
  # Test Different Library locations

  skip_if(getOption("repos") == "fake-cran.fake-r-project.org",
          message = "pkg source tests skipped")

  tempLibLoc <- tempdir()
  install.packages("coin", lib = tempLibLoc)
  ref8 <- pkg_ref("coin", source = "pkg_install", lib.loc = tempLibLoc)

  expect_equal(ref1$source, "pkg_install")
  expect_equal(ref2$source, "pkg_remote")
  # For some reason bioconductor packages have different source values.
  expect_equal(ref3$source, "pkg_remote")
  expect_equal(ref4$source, "pkg_source")
  expect_equal(ref5$source, "pkg_remote")
  expect_equal(sapply(ref6, `[[`, "source"), c("pkg_remote", "pkg_remote"))
  expect_equal(sapply(ref7, `[[`, "source"), c("pkg_install", "pkg_remote"))
  expect_equal(ref8$source, "pkg_install")
})

test_that("pkg_ref throws nice warnings when you give bad 'source' arguments",{

  expect_warning(p1 <- pkg_ref("UnknownCRANPkg", source = "pkg_cran_remote"),
                 "Package: `UnknownCRANPkg` not found on CRAN, source is now 'pkg_missing'")
  expect_equal(p1$source, "pkg_missing")

  expect_warning(p2 <- pkg_ref("UnknownBiocPkg", source = "pkg_bioc_remote"),
                 "Package: `UnknownBiocPkg` not found on bioconductor, source is now 'pkg_missing'")
  expect_equal(p2$source, "pkg_missing")

  expect_warning(p3 <- pkg_ref("./MissingPackage", source = "pkg_source"),
                 "Package source: `./MissingPackage` does not exist, source is now 'pkg_missing'")
  expect_equal(p3$source, "pkg_missing")
})
