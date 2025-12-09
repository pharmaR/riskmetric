# Handle pretty printing of expression output

Handle pretty printing of expression output

## Usage

``` r
# S3 method for class 'with_eval_recording'
print(x, playback = FALSE, cr = TRUE, ..., sleep = 0)
```

## Arguments

- x:

  expr_output to print

- playback:

  a `logical` indicating whether evaluation output should be played back
  (`FALSE`), or whether the result value should be printed as is
  (`TRUE`, the default)

- cr:

  a `logical` indicating whether carriage returns should be printed,
  possibly overwriting characters in the output.

- ...:

  additional arguments unused

- sleep:

  an `numeric` indicating a time to sleep between printing each line to
  console. This can be helpful if the original output overwrites
  valuable information in the log that is eventually overwritten and you
  would like to watch it play out as it was formatted.

## Value

a print message
