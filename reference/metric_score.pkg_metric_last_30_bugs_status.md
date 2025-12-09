# Score a package for number of recently opened BugReports that are now closed

Score a package for number of recently opened BugReports that are now
closed

## Usage

``` r
# S3 method for class 'pkg_metric_last_30_bugs_status'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_last_30_bugs_status` packge metric object

- ...:

  additional arguments unused

## Value

a fractional value indicating percentage of last 30 bug reports that are
now closed

## Examples

``` r
if (FALSE) metric_score(assess_last_30_bugs_status(pkg_ref("riskmetric")))
 # \dontrun{}
```
