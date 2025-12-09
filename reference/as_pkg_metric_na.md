# A pkg_metric subclass for when metrics are explicitly not applicable

A pkg_metric subclass for when metrics are explicitly not applicable

## Usage

``` r
as_pkg_metric_na(x, message = NULL)
```

## Arguments

- x:

  a `pkg_metric` object to wrap in a `pkg_metric_na` subclass

- message:

  an optional message explaining why a metric is not applicable.

## Value

a `pkg_metric` object after wrap in a `pkg_metric_na`
