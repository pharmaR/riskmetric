# Assess a package for the presence of Vignettes files

Assess a package for the presence of Vignettes files

## Usage

``` r
assess_has_vignettes(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing an integer value indicating the number of
discovered vignettes files

## See also

[`metric_score.pkg_metric_has_vignettes`](metric_score.pkg_metric_has_vignettes.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_has_vignettes(pkg_ref("riskmetric"))
} # }
```
