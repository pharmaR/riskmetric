### Actual Snapshots

test_that("Test source packages", {
  # Packages are embedded in directories in the testing folder and are created
  # in setup_test_packages.R

  expect_snapshot_output(pkg_ref_source_good)
  expect_snapshot_output(assess_source_good)

  expect_snapshot_output(pkg_ref_source_good)
  expect_snapshot_output(assess_source_bad)
})

test_that("Test remote CRAN packages", {
  # Packages were selected because they are not dependencies of this package

  expect_snapshot_output(pkg_ref_cran_remote_good)
  expect_snapshot_output(assess_cran_remote_good)

  expect_snapshot_output(pkg_ref_cran_remote_bad)
  expect_snapshot_output(assess_cran_remote_bad)
})

test_that("Test installed packages", {
  # Packages were selected because they are dependencies of this package.

  expect_snapshot_output(pkg_ref_stdlib_install)
  expect_snapshot_output(assess_stdlib_install)
})
