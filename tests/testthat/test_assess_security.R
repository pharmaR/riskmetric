test_that("assess_security returns expected result for test packages", {


  # true positive case for one with vuln

  # fake one returns NA

  # true negative includes 0
  # ── Vulnerability overview ──
  #
  # ℹ 1 package was scanned
  # ℹ 1 package was found in the Sonatype database
  # ℹ 0 packages had known vulnerabilities
  # ℹ A total of 0 known vulnerabilities were identified
  # ℹ See https://github.com/sonatype-nexus-community/oysteR/ for details.


  # txt <- capture.output({tmp <- oysteR::audit(c("widgetframe", "ggplot2"), c("0.3.1", "1.0.0"), "cran")}, type = "message")
  # txt2 <- capture.output({tmp <- oysteR::audit("fakepackage", "cran")}, type = "message")


  # cant "know" what is missing
  # https://github.com/sonatype-nexus-community/oysteR/issues/62



  # should we also cache what comes out of vulnerabilities


  # expect_numeric(assess_source_good$security)
  browser()
  expect_equal(assess_source_good$security, 0)

  # pkg_assess(assess_source_good, assessments = all_assessments(include_suggests = T))

})

