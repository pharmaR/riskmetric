# Evaluate a metric

Evalute code relevant to a metric, capturing the evaluated code as well
as any messages, warnings or errors that are thrown in the process.

## Usage

``` r
pkg_metric_eval(expr, ..., class = c(), env = parent.frame())
```

## Arguments

- expr:

  An expression to evaluate in order to calculate a `pkg_metric`

- ...:

  additional attributes to bind to the `pkg_metric` object

- class:

  a subclass to differentiate the `pkg_metric` object

- env:

  An environment in which `expr` is to be evaluated

## Value

a `pkg_metric` object containing the result of `expr`
