# a wrapper to assert that a pkg_ref has been permitted to do an additional mutation, used to handle recursive initialization of cached fields

a wrapper to assert that a pkg_ref has been permitted to do an
additional mutation, used to handle recursive initialization of cached
fields

## Usage

``` r
allow_mutation(x, expr, envir = parent.frame())
```

## Arguments

- x:

  a `pkg_ref` object

- expr:

  an expression to evaluate, and possible do a mutation within

- envir:

  an environment in which the expression is to be evaluated

## Value

the result of `expr`
