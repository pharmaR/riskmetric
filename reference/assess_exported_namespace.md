# Assess a package's results from running R CMD check

Assess a package's results from running R CMD check

## Usage

``` r
assess_exported_namespace(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing List of functions and objects exported by a
package, excluding S3methods

## See also

[`metric_score.pkg_metric_exported_namespace`](metric_score.pkg_metric_exported_namespace.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_exported_namespace(pkg_ref("riskmetric"))
} # }
```
