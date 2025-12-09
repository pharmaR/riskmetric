# Assessment of dependency footprint for a specific package

Only Depends, Imports and LinkingTo dependencies are assessed because
they are required

## Usage

``` r
assess_dependencies(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a dataframe of package names and they type of
dependency the package being assess has to them

## Details

The more packages a package relies on the more chances for errors exist.

## See also

[`metric_score.pkg_metric_dependencies`](metric_score.pkg_metric_dependencies.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_dependencies(pkg_ref("riskmetric"))
} # }
```
