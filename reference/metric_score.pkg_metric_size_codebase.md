# Score a package for number of lines of code

Scores packages based on its codebase size, as determined by number of
lines of code.

## Usage

``` r
# S3 method for class 'pkg_metric_size_codebase'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_size_codebase` packge metric object

- ...:

  additional arguments unused

## Value

numeric value between `0` (for large codebase) and `1` (for small
codebase)

## Examples

``` r
if (FALSE) metric_score(assess_size_codebase(pkg_ref("riskmetric")))
 # \dontrun{}
```
