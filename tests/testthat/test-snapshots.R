### Actual Snapshots

test_that("Test source packages", {
  # Packages are embedded in directories in the testing folder and are created
  # in setup-xyz.R

  expect_snapshot_output(ref_source_1)

  expect_snapshot_output(ref_source_2)

  expect_snapshot_output(assess_source_1)

  expect_snapshot_output(assess_source_2)
})

test_that("Test remote CRAN packages", {
  # Packages were selected because they are not dependencies of this package

  expect_snapshot_output(ref_CRAN_remote_1)

  expect_snapshot_output(ref_CRAN_remote_1)

  expect_snapshot_output(assess_CRAN_remote_1)

  expect_snapshot_output(assess_CRAN_remote_2)
})

test_that("Test installed packages", {
  # Packages were selected because they are dependencies of this package.

  expect_snapshot_output(ref_installed_package_1)

  expect_snapshot_output(ref_installed_package_2)

  expect_snapshot_output(assess_installed_package_1)

  expect_snapshot_output(assess_installed_package_2)
})
