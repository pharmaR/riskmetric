# Evaluate an expression in the context of a pkg_ref

`pkg_ref` objects are environments and can be passed to `with` in much
the same way. This specialized function makes sure that any fields
within the `pkg_ref` have been appropriately evaluated before trying to
execute the expression.

## Usage

``` r
# S3 method for class 'pkg_ref'
with(data, expr, ...)
```

## Arguments

- data:

  data to use for constructing an environment. For the default `with`
  method this may be an environment, a list, a data frame, or an integer
  as in `sys.call`. For `within`, it can be a list or a data frame.

- expr:

  expression to evaluate; particularly for
  [`within()`](https://rdrr.io/r/base/with.html) often a “compound”
  expression, i.e., of the form

         {
           a <- somefun()
           b <- otherfun()
           .....
           rm(unused1, temp)
         }

- ...:

  arguments to be passed to (future) methods.

## Value

the value of the evaluated expr.
