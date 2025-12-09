# Score a package for inclusion of an associated maintainer

Coerce a list of maintainers into a numeric value indicating whether the
number of listed maintainers is greater than 0.

## Usage

``` r
# S3 method for class 'pkg_metric_has_maintainer'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_has_maintainer` packge metric object

- ...:

  additional arguments unused

## Value

`1` if any maintainer is provided, otherwise `0`

## Examples

``` r
if (FALSE) metric_score(assess_has_maintainer(pkg_ref("riskmetric")))
 # \dontrun{}
```
