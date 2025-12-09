# evaluate an expression with a pkg_ref object reclassed as a bare environment object, used to sidestep pkg_ref assignment guardrails

evaluate an expression with a pkg_ref object reclassed as a bare
environment object, used to sidestep pkg_ref assignment guardrails

## Usage

``` r
bare_env(x, expr, envir = parent.frame())
```

## Arguments

- x:

  a `pkg_ref` object

- expr:

  an expression to evaluate, avoiding `pkg_ref` extraction handlers

- envir:

  an environment in which the expression is to be evaluated

## Value

the result of `expr`
