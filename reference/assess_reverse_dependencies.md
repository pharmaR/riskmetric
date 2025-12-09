# Generate list of Reverse Dependencies for a package

Generate list of Reverse Dependencies for a package

## Usage

``` r
assess_reverse_dependencies(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing A character vector of reverse dependencies

## Details

The more packages that depend on a package the more chance for
errors/bugs to be found

## See also

[`metric_score.pkg_metric_reverse_dependencies`](metric_score.pkg_metric_reverse_dependencies.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_reverse_dependencies(pkg_ref("riskmetric"))
} # }
```
