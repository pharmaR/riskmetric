test_that("assess_security returns expected result for test packages", {

  # Case 1: No vulnerabilities detected by oysteR
  #
  # This covers any scenario where oysteR does not report back a
  # vulnerability. Note that it is not possible to distinguish between a
  # "true negative" (e.g. where the package was scanned and nothing was found)
  # and a package not found in the index that is being scanned by oysteR. A
  # good discussion on this topic can be found here:
  #
  #     https://github.com/sonatype-nexus-community/oysteR/issues/62
  #
  # Given riskmetric's inability to distinguish between these two cases, the
  # returned metric score is NA to make sure the end user does not get a false
  # sense of security.

  # the mock for this call lives in:
  #
  #     tests/testthat/test_webmocks/data/sonatype_response.json
  #
  # and contains no vulnerabilities
  expect_equal(unclass(assess_source_good$security[[1]]), 0)
  expect_equal(metric_score(assess_source_good$security), NA)


  # Case 2: Vulnerabilities detected by oysteR
  #
  # This covers scenarios where oysteR reports back any vulnerabilities. The
  # mock for the test has been set up to return the response for a query on
  # v0.1.1 of the haven package. It was produced by inspecting the JSON response
  # for the following call:
  #
  #     oysteR::audit(pkg = "haven", version = "0.1.1", type = "cran")
  #
  # which is known to return 3 vulnerabilities:
  #
  #     https://ossindex.sonatype.org/component/pkg:cran/haven@0.1.1
  #
  expect_equal(unclass(assess_source_bad$security[[1]]), 3)
  expect_equal(metric_score(assess_source_bad$security), 0)

})

