# Capture side effects issued by an evaluated expression

All messaging condition side effects are captured in the order that they
are issued.

## Usage

``` r
capture_expr_output(expr, split = FALSE, env = parent.frame(), quoted = FALSE)
```

## Arguments

- expr:

  an expression to evaluate, capturing output events as they are issued

- split:

  logical: if `TRUE`, output will be sent to the new sink and to the
  current output stream, like the Unix program `tee`.

- env:

  the environment in which `expr` should be evaluated, defaulting to the
  calling environment.

- quoted:

  whether `expr` is a quoted object and should be evaluated as is, or
  whether the expression should be captured from the function call.
  Defaults to `FALSE`, capturing the passed expression.

## Value

an with_eval_recording object
