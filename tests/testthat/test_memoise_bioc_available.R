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


test_that("bioc_repositories() honours the riskmetric.bioc_repos option override", {
  withr::local_options(
    riskmetric.bioc_repos = c(BioC = "https://internal.example.com/bioc")
  )
  expect_equal(
    unname(bioc_repositories()),
    "https://internal.example.com/bioc"
  )
})

test_that("bioc_repositories() honours the RISKMETRIC_BIOC_REPOS env var", {
  withr::local_options(riskmetric.bioc_repos = NULL)
  withr::local_envvar(
    RISKMETRIC_BIOC_REPOS = "https://a.example.com/bioc,https://b.example.com/bioc"
  )
  expect_equal(
    bioc_repositories(),
    c("https://a.example.com/bioc", "https://b.example.com/bioc")
  )
})

test_that("bioc_repositories() falls through to options('repos') by URL pattern", {
  withr::local_options(
    riskmetric.bioc_repos = NULL,
    repos = c(
      CRAN = "https://internal.example.com/cran/latest",
      PPM_Bioc = "https://internal.example.com/bioconductor-3.22/latest"
    )
  )
  withr::local_envvar(RISKMETRIC_BIOC_REPOS = "")
  # Force BiocManager::repositories() out of the picture for the test.
  with_mocked_bindings(
    repositories = function(...) stop("no BiocManager on this host"),
    .package = "BiocManager",
    {
      res <- bioc_repositories()
      expect_length(res, 1L)
      expect_match(res, "bioconductor-3.22")
    }
  )
})

test_that("is_available_cran() vetoes packages known to memoise_bioc_available", {
  fake_bioc <- data.frame(
    Package = "BiocGenerics", Version = "0.99.0",
    Repository = "https://internal.example.com/bioc/src/contrib",
    stringsAsFactors = FALSE
  )
  fake_cran <- matrix(
    c("BiocGenerics", "0.99.0", "https://internal.example.com/cran"),
    nrow = 1, byrow = TRUE,
    dimnames = list(NULL, c("Package", "Version", "Repository"))
  )
  with_mocked_bindings(
    memoise_bioc_available = function() fake_bioc,
    memoise_available_packages = function(repos = NULL, ...) fake_cran,
    memoise_cran_mirrors = function() NULL,
    {
      expect_false(
        is_available_cran("BiocGenerics",
                          repos = c(CRAN = "https://internal.example.com/cran"),
                          p = list(repo_base_url = NA_character_))
      )
    }
  )
})
