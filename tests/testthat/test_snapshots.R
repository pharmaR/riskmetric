### Actual Snapshots

if (packageVersion("testthat") >= package_version("2.99")) {
  local_edition(3L)

  test_that("Test source packages", {
    skip("snapshots appear to be failing due to random order of pkg_ref fields")

    # Packages are embedded in directories in the testing folder and are created
    # in setup_test_packages.R

    expect_snapshot_output(pkg_ref_source_good)
    expect_snapshot_output(assess_source_good)

    expect_snapshot_output(pkg_ref_source_good)
    expect_snapshot_output(assess_source_bad)
  })

  test_that("Test remote CRAN packages", {
    skip("snapshots appear to be failing due to random order of pkg_ref fields")

    # Packages were selected because they are not dependencies of this package
    # NOTE: pkg_refs fail because output of $web_html is a pointer memory
    #       address which change with each run. tests disabled until we can
    #       figure out a workaround.

    # expect_snapshot_output(pkg_ref_cran_remote_good)
    expect_snapshot_output(assess_cran_remote_good)

    # expect_snapshot_output(pkg_ref_cran_remote_bad)
    expect_snapshot_output(assess_cran_remote_bad)
  })

  test_that("Test installed packages", {
    skip("snapshots appear to be failing due to random order of pkg_ref fields")

    # Packages were selected because they are dependencies of this package.

    expect_snapshot_output(pkg_ref_stdlib_install)
    expect_snapshot_output(assess_stdlib_install)
  })
}
