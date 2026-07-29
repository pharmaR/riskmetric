test_that("bioc_repositories() filters BiocManager::repositories() to BioC entries", {
  fake_repos <- c(
    BioCsoft      = "http://example.com/bioc",
    BioCann       = "http://example.com/data/annotation",
    BioCexp       = "http://example.com/data/experiment",
    BioCworkflows = "http://example.com/workflows",
    BioCbooks     = "http://example.com/books",
    CRAN          = "http://example.com/cran"
  )

  with_mocked_bindings(
    repositories = function(...) fake_repos,
    .package = "BiocManager",
    {
      out <- bioc_repositories()
      expect_named(out, c("BioCsoft", "BioCann", "BioCexp",
                          "BioCworkflows", "BioCbooks"))
      expect_false("CRAN" %in% names(out))
    }
  )
})

test_that("bioc_repositories() returns character(0) when BiocManager errors", {
  with_mocked_bindings(
    repositories = function(...) stop("no network"),
    .package = "BiocManager",
    {
      expect_identical(bioc_repositories(), character(0))
    }
  )
})

test_that("memoise_bioc_available() combines all BioC repositories", {
  memoise::forget(memoise_bioc_available)

  fake_repos <- c(
    BioCsoft = "http://example.com/bioc",
    BioCann  = "http://example.com/data/annotation",
    BioCexp  = "http://example.com/data/experiment"
  )

  fake_ap <- rbind(
    c(Package = "SoftPkg", Version = "1.0",
      Repository = "http://example.com/bioc/src/contrib"),
    c(Package = "AnnPkg",  Version = "2.0",
      Repository = "http://example.com/data/annotation/src/contrib"),
    c(Package = "ExpPkg",  Version = "3.0",
      Repository = "http://example.com/data/experiment/src/contrib")
  )

  with_mocked_bindings(
    repositories = function(...) fake_repos,
    .package = "BiocManager",
    {
      with_mocked_bindings(
        available.packages = function(repos = NULL, ...) fake_ap,
        .package = "utils",
        {
          out <- memoise_bioc_available()
          expect_true(all(c("SoftPkg", "AnnPkg", "ExpPkg") %in% out[["Package"]]))
          expect_true("Repository" %in% names(out))
        }
      )
    }
  )

  memoise::forget(memoise_bioc_available)
})

test_that("memoise_bioc_available() returns an empty frame when no BioC repos exist", {
  memoise::forget(memoise_bioc_available)

  with_mocked_bindings(
    repositories = function(...) character(0),
    .package = "BiocManager",
    {
      out <- memoise_bioc_available()
      expect_s3_class(out, "data.frame")
      expect_equal(nrow(out), 0L)
      expect_true(all(c("Package", "Version", "Repository") %in% names(out)))
    }
  )

  memoise::forget(memoise_bioc_available)
})
