# Evaluate an expression after first removing a range of S3 classes

Evaluate an expression after first removing a range of S3 classes

## Usage

``` r
with_unclassed_to(x, .class = 1:length(class(x)), expr, envir = parent.frame())
```

## Arguments

- x:

  a structured S3-classed object

- .class:

  the class to unclass the object to

- expr:

  an expression to evaluate, avoiding parent classs dispatch

- envir:

  an environment in which the expression is to be evaluated

## Value

the result of `expr`
