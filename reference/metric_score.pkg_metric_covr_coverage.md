# Score a package for unit test coverage

Returns the overall test coverage from a covr coverage report

## Usage

``` r
# S3 method for class 'pkg_metric_covr_coverage'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_covr_coverage` packge metric object

- ...:

  additional arguments unused

## Value

A `numeric`

## Examples

``` r
if (FALSE) metric_score(assess_covr_coverage(pkg_ref("riskmetric")))
 # \dontrun{}
```
