# Package index

## Package Reference

Create Package Reference for Each Package Risk Metric and Cache Metadata

- [`pkg_ref()`](pkg_ref.md) [`pkg_install()`](pkg_ref.md)
  [`pkg_source()`](pkg_ref.md) [`pkg_cran()`](pkg_ref.md)
  [`pkg_bioc()`](pkg_ref.md) [`pkg_missing()`](pkg_ref.md)
  [`pkg_library()`](pkg_ref.md) [`as_pkg_ref()`](pkg_ref.md) : Create a
  package reference
- [`pkg_ref_class_hierarchy`](pkg_ref_class_hierarchy.md) : The
  \`pkg_ref\` subclass hierarchy, used for pkg_ref object creation with
  a specified subclass
- [`pkg_ref_cache`](riskmetric_metadata_caching.md) : S3 generic to
  calculate a \`pkg_ref\` field

## Package Assessment

Assess Package Metadata against a risk criterion

- [`pkg_assess()`](pkg_assess.md) : Apply assess\_\* family of functions
  to a package reference
- [`all_assessments()`](all_assessments.md) : A default list of
  assessments to perform for each package
- [`get_assessments()`](get_assessments.md) : Get a specific set of
  assess\_\* functions for pkg_assess
- [`assess_covr_coverage()`](assess_covr_coverage.md) : Assess a package
  code coverage using the \`covr\` package
- [`assess_dependencies()`](assess_dependencies.md) : Assessment of
  dependency footprint for a specific package
- [`assess_downloads_1yr()`](assess_downloads_1yr.md) : Assess a package
  for the number of downloads in the past year
- [`assess_export_help()`](assess_export_help.md) : Assess a package for
  availability of documentation for exported values
- [`assess_exported_namespace()`](assess_exported_namespace.md) : Assess
  a package's results from running R CMD check
- [`assess_has_bug_reports_url()`](assess_has_bug_reports_url.md) :
  Assess a package for the presence of a url field where bugs can be
  reported.
- [`assess_has_examples()`](assess_has_examples.md) : Assess a package
  for the presence of example or usage fields in function documentation
- [`assess_has_maintainer()`](assess_has_maintainer.md) : Assess a
  package for an associated maintainer
- [`assess_has_news()`](assess_has_news.md) : Assess a package for the
  presence of a NEWS file
- [`assess_has_source_control()`](assess_has_source_control.md) : Assess
  a package for an associated source control url
- [`assess_has_vignettes()`](assess_has_vignettes.md) : Assess a package
  for the presence of Vignettes files
- [`assess_has_website()`](assess_has_website.md) : Assess a package for
  an associated website url
- [`assess_last_30_bugs_status()`](assess_last_30_bugs_status.md) :
  Assess how many recent BugReports have been closed
- [`assess_license()`](assess_license.md) : Assess a package for an
  acceptable license
- [`assess_news_current()`](assess_news_current.md) : Assess a package
  for an up-to-date NEWS file
- [`assess_r_cmd_check()`](assess_r_cmd_check.md) : Assess a package's
  results from running R CMD check
- [`assess_remote_checks()`](assess_remote_checks.md) : Assess package
  checks from CRAN/Bioc or R CMD check
- [`assess_reverse_dependencies()`](assess_reverse_dependencies.md) :
  Generate list of Reverse Dependencies for a package
- [`assess_size_codebase()`](assess_size_codebase.md) : Assess a package
  for size of code base
- [`assessment_error_as_warning()`](assessment_error_as_warning.md) :
  Error handler for assessments to deescalate errors to warnings
- [`assessment_error_empty()`](assessment_error_empty.md) : Error
  handler for assessments with safe fallback
- [`assessment_error_throw()`](assessment_error_throw.md) : Error
  handler for assessments to throw error immediately

## Package Risk Score

Provide Risk Score based on Risk Metrics

- [`pkg_score()`](pkg_score.md) : Score a package assessment, collapsing
  results into a single numeric
- [`pkg_metric()`](pkg_metric.md) : A helper for structuring assessment
  return objects for dispatch with the score function
- [`metric_score()`](metric_score.md) : Score a package metric
- [`metric_score(`*`<pkg_metric_covr_coverage>`*`)`](metric_score.pkg_metric_covr_coverage.md)
  : Score a package for unit test coverage
- [`metric_score(`*`<pkg_metric_dependencies>`*`)`](metric_score.pkg_metric_dependencies.md)
  : Score a package for dependencies
- [`metric_score(`*`<pkg_metric_downloads_1yr>`*`)`](metric_score.pkg_metric_downloads_1yr.md)
  : Defining an Assessment Scoring Function
- [`metric_score(`*`<pkg_metric_export_help>`*`)`](metric_score.pkg_metric_export_help.md)
  : Score a package for availability of documentation for exported
  values
- [`metric_score(`*`<pkg_metric_exported_namespace>`*`)`](metric_score.pkg_metric_exported_namespace.md)
  : Score a package for the number of exported objects
- [`metric_score(`*`<pkg_metric_has_bug_reports_url>`*`)`](metric_score.pkg_metric_has_bug_reports_url.md)
  : Score a package for the presence of a bug report url
- [`metric_score(`*`<pkg_metric_has_examples>`*`)`](metric_score.pkg_metric_has_examples.md)
  : Score a package for the presence of a example or usage fields
- [`metric_score(`*`<pkg_metric_has_maintainer>`*`)`](metric_score.pkg_metric_has_maintainer.md)
  : Score a package for inclusion of an associated maintainer
- [`metric_score(`*`<pkg_metric_has_news>`*`)`](metric_score.pkg_metric_has_news.md)
  : Score a package for the presence of a NEWS file
- [`metric_score(`*`<pkg_metric_has_source_control>`*`)`](metric_score.pkg_metric_has_source_control.md)
  : Score a package for inclusion of an associated source control url
- [`metric_score(`*`<pkg_metric_has_vignettes>`*`)`](metric_score.pkg_metric_has_vignettes.md)
  : Score a package for the presence of a Vignettes file
- [`metric_score(`*`<pkg_metric_has_website>`*`)`](metric_score.pkg_metric_has_website.md)
  : Score a package for inclusion of an associated website url
- [`metric_score(`*`<pkg_metric_last_30_bugs_status>`*`)`](metric_score.pkg_metric_last_30_bugs_status.md)
  : Score a package for number of recently opened BugReports that are
  now closed
- [`metric_score(`*`<pkg_metric_license>`*`)`](metric_score.pkg_metric_license.md)
  : Score a package for acceptable license
- [`metric_score(`*`<pkg_metric_news_current>`*`)`](metric_score.pkg_metric_news_current.md)
  : Score a package for NEWS files updated to current version
- [`metric_score(`*`<pkg_metric_r_cmd_check>`*`)`](metric_score.pkg_metric_r_cmd_check.md)
  : Score a package based on R CMD check results run locally
- [`metric_score(`*`<pkg_metric_remote_checks>`*`)`](metric_score.pkg_metric_remote_checks.md)
  : Score a package based on R CMD check results run by BioC or CRAN
- [`metric_score(`*`<pkg_metric_reverse_dependencies>`*`)`](metric_score.pkg_metric_reverse_dependencies.md)
  : Scoring method for number of reverse dependencies a package has
- [`metric_score(`*`<pkg_metric_size_codebase>`*`)`](metric_score.pkg_metric_size_codebase.md)
  : Score a package for number of lines of code

## Package Risk Summary

Summarizing across metric scores

- [`summarize_scores()`](summarize_scores.md) : Summarize a default set
  of assessments into a single risk score

## Metric Error Handler

Error handler functions

- [`assessment_error_as_warning()`](assessment_error_as_warning.md) :
  Error handler for assessments to deescalate errors to warnings
- [`assessment_error_empty()`](assessment_error_empty.md) : Error
  handler for assessments with safe fallback
- [`assessment_error_throw()`](assessment_error_throw.md) : Error
  handler for assessments to throw error immediately
- [`score_error_NA()`](score_error_NA.md) : Score error handler to
  silently return NA
- [`score_error_default()`](score_error_default.md) : Default score
  error handling, emitting a warning and returning 0
- [`score_error_zero()`](score_error_zero.md) : Score error handler to
  silently return 0

## Utilities

Utility functions

- [`as_pkg_metric()`](as_pkg_metric.md) :

  Convert an object to a `pkg_metric`

- [`pkg_ref()`](pkg_ref.md) [`pkg_install()`](pkg_ref.md)
  [`pkg_source()`](pkg_ref.md) [`pkg_cran()`](pkg_ref.md)
  [`pkg_bioc()`](pkg_ref.md) [`pkg_missing()`](pkg_ref.md)
  [`pkg_library()`](pkg_ref.md) [`as_pkg_ref()`](pkg_ref.md) : Create a
  package reference
