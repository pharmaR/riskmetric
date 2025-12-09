# Lazily instantiated, immutable metadata access

If errors are thrown upon instantiation, they are saved and rethrown any
time the value is attempted to be accessed. These then propegate through
assessment and scoring functions to affect any downstream metrics.

## Usage

``` r
# S3 method for class 'pkg_ref'
x[[name, ...]]
```

## Arguments

- x:

  pkg_ref object to extract metadata from

- name:

  name of metadata field to extract

- ...:

  additional arguments used to extract from internal environment

## Value

a pkg_ref object
