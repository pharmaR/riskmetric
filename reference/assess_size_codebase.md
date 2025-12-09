# Assess a package for size of code base

Assess a package for size of code base

## Usage

``` r
assess_size_codebase(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a numeric value for number of lines of code
base for a package

## See also

[`metric_score.pkg_metric_size_codebase`](metric_score.pkg_metric_size_codebase.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_size_codebase(pkg_ref("riskmetric"))
} # }
```
