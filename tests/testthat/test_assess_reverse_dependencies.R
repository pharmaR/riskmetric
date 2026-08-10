test_that("assess_reverse_dependencies.default computes revdeps from available.packages()", {
  # Build a fake CRAN-style available-packages matrix with three reverse
  # dependents of the target package "target" (via Depends, Imports, and
  # LinkingTo), plus one unrelated package.
  fake_available <- matrix(
    c(
      "revA",     "1.0", "target",  "",         "",       "",
      "revB",     "2.0", "",        "target",   "",       "",
      "revC",     "3.0", "",        "",         "target", "",
      "unrelated","0.1", "utils",   "",         "",       ""
    ),
    ncol  = 6,
    byrow = TRUE,
    dimnames = list(NULL, c("Package", "Version", "Depends",
                            "Imports", "LinkingTo", "Suggests"))
  )
  # Package-level Repository column is required by tools::dependsOnPkgs
  fake_available <- cbind(
    fake_available,
    Repository = "https://example.test/src/contrib"
  )

  x <- list(name = "target")
  res <- assess_reverse_dependencies.default(x, available = fake_available)

  expect_s3_class(res, "pkg_metric_reverse_dependencies")
  expect_setequal(as.character(res), c("revA", "revB", "revC"))
})

test_that("assess_reverse_dependencies.default respects the `dependencies` filter", {
  fake_available <- matrix(
    c(
      "revA",     "1.0", "target",  "",       "",       "",
      "revB",     "2.0", "",        "target", "",       "",
      "revC",     "3.0", "",        "",       "",       "target"
    ),
    ncol  = 6,
    byrow = TRUE,
    dimnames = list(NULL, c("Package", "Version", "Depends",
                            "Imports", "LinkingTo", "Suggests"))
  )
  fake_available <- cbind(
    fake_available,
    Repository = "https://example.test/src/contrib"
  )
  x <- list(name = "target")

  res_all <- assess_reverse_dependencies.default(
    x,
    available = fake_available,
    dependencies = c("Depends", "Imports", "LinkingTo", "Suggests")
  )
  expect_setequal(as.character(res_all), c("revA", "revB", "revC"))

  res_depends_only <- assess_reverse_dependencies.default(
    x,
    available = fake_available,
    dependencies = "Depends"
  )
  expect_setequal(as.character(res_depends_only), "revA")
})

test_that("assess_reverse_dependencies.default returns an empty result cleanly", {
  fake_available <- matrix(
    c("unrelated", "0.1", "utils", "", "", ""),
    ncol  = 6,
    byrow = TRUE,
    dimnames = list(NULL, c("Package", "Version", "Depends",
                            "Imports", "LinkingTo", "Suggests"))
  )
  fake_available <- cbind(
    fake_available,
    Repository = "https://example.test/src/contrib"
  )

  x <- list(name = "target")
  res <- assess_reverse_dependencies.default(x, available = fake_available)

  expect_s3_class(res, "pkg_metric_reverse_dependencies")
  expect_length(as.character(res), 0L)
})
