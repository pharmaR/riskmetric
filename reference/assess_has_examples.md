# Assess a package for the presence of example or usage fields in function documentation

Assess a package for the presence of example or usage fields in function
documentation

## Usage

``` r
assess_has_examples(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing an integer value indicating the proportion of
discovered files with examples

## See also

[`metric_score.pkg_metric_has_examples`](metric_score.pkg_metric_has_examples.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_has_examples(pkg_ref("riskmetric"))
} # }
```
