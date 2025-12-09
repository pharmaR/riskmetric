# Score a package for the presence of a bug report url

Score a package for the presence of a bug report url

## Usage

``` r
# S3 method for class 'pkg_metric_has_bug_reports_url'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_has_bug_reports_url` packge metric object

- ...:

  additional arguments unused

## Value

A logical value indicating whether the package has a BugReports field
filled in

## Examples

``` r
if (FALSE) metric_score(assess_has_bug_reports_url(pkg_ref("riskmetric")))
 # \dontrun{}
```
