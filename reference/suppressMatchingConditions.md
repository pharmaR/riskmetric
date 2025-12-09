# Suppress messages and warnings based on one or more regex matches

Suppress messages and warnings based on one or more regex matches

## Usage

``` r
suppressMatchingConditions(expr, ..., .opts = list(), .envir = parent.frame())
```

## Arguments

- expr:

  An expression to evaluate

- ...:

  Named parameters, where the name indicates the class of conditions to
  capture and the value is a vector of regular expressions that, when
  matched against the respective condition message, should suppress that
  condition.

- .opts:

  A named list of arguments to pass to `grepl`

- .envir:

  The environment in which `expr` is to be evaluated

## Value

a message printed on console
