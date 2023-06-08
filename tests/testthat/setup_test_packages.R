# create a series of reliably evaluated pkg reference objects that can be
# reused throughout testthat unit tests

# NOTE: score_error_zero is used for all scoring functions to suppress warnings
# and explicitly return zeros whenever errors are captured throughout the
# evaluation process. Errors are better tested in metric-specific unit tests.

# create a temporary library for installed test packages
templib <- tempfile("riskmetric_test_lib_")
dir.create(templib)

withr::with_libpaths(templib, {
  devtools::install(
    file.path(test_path(), "test_packages", "pkgsourcegood"),
    quiet = TRUE,
    reload = FALSE
  )

  # a representative "good" quality package from an installed package
  pkg_ref_install_good <- pkg_install("pkgsourcegood")
  assess_install_good <- pkg_assess(pkg_ref_install_good)
  score_install_good <- pkg_score(
    assess_install_good,
    error_handler = score_error_zero)
})

# a representative "good" quality package from source code
pkg_ref_source_good <- pkg_source(file.path(test_path(), "test_packages", "pkgsourcegood"))
assess_source_good <- pkg_assess(pkg_ref_source_good)
score_source_good <- pkg_score(
  assess_source_good,
  error_handler = score_error_zero)

# a representative "bad" pkg_source package from source code
pkg_ref_source_bad <- pkg_source(file.path(test_path(), "test_packages", "pkgsourcebad"))
assess_source_bad <- pkg_assess(pkg_ref_source_bad)
score_source_bad <- pkg_score(
  assess_source_bad,
  error_handler = score_error_zero)

# another representative "bad" pkg_source package from source code
pkg_ref_source_bad2 <- pkg_source(file.path(test_path(), "test_packages", "pkgsourcebad2"))
assess_source_bad2 <- pkg_assess(pkg_ref_source_bad2)
score_source_bad2 <- pkg_score(
  assess_source_bad2,
  error_handler = score_error_zero)

# a representative package from an installed library
pkg_ref_stdlib_install <- pkg_install("utils")
assess_stdlib_install <- pkg_assess(pkg_ref_stdlib_install)
score_stdlib_install <- pkg_score(
  assess_stdlib_install,
  error_handler = score_error_zero)

# a representative cohort of packages from an installed library
pkg_ref_stdlibs_install <- pkg_ref(c("utils", "tools"), source = "pkg_install")
assess_stdlibs_install <- pkg_assess(pkg_ref_stdlibs_install)
score_stdlibs_install <- pkg_score(
  assess_stdlibs_install,
  error_handler = score_error_zero)

# a representative "good" quality package available on CRAN, but not installed
pkg_ref_cran_remote_good <- pkg_cran("pkgcranremotegood", list(repo="https://cranrepo.org/"))
assess_cran_remote_good <- pkg_assess(pkg_ref_cran_remote_good)
score_cran_remote_good <- pkg_score(
  assess_cran_remote_good,
  error_handler = score_error_zero)

# a representative "bad" quality package available on CRAN, but not installed
pkg_ref_cran_remote_bad  <- pkg_cran("pkgcranremotebad")
assess_cran_remote_bad <- pkg_assess(pkg_ref_cran_remote_bad)
score_cran_remote_bad <- pkg_score(
  assess_cran_remote_bad,
  error_handler = score_error_zero)

# a representative package without a discoverable reference
pkg_ref_missing <- pkg_missing("pkgmissing")
assess_pkg_missing <- pkg_assess(pkg_ref_missing)
score_pkg_missing <- pkg_score(
  assess_pkg_missing,
  error_handler = score_error_zero)

withr::defer(unlink(templib, recursive = TRUE), teardown_env())

