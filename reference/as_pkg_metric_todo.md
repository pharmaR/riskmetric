# A pkg_metric subclass for when pkg_metrics have not yet been implemented

A pkg_metric subclass for when pkg_metrics have not yet been implemented

## Usage

``` r
as_pkg_metric_todo(x, message = NULL)
```

## Arguments

- x:

  a `pkg_metric` object to wrap in a `pkg_metric_todo` subclass

- message:

  an optional message directing users and potential contributors toward
  any ongoing work or first steps toward development.

## Value

a `pkg_metric` object after wrap in a `pkg_metric_todo`
