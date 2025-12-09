# pretty printing for a pkg_ref mutability error caused by trying to do assignment within the pkg_ref without permission

pretty printing for a pkg_ref mutability error caused by trying to do
assignment within the pkg_ref without permission

## Usage

``` r
pkg_ref_mutability_error(name)
```

## Arguments

- name:

  name of field for which mutation was attempted

## Value

a `simplError` with subclasses `pkg_ref_mutability_error`,
`pkg_ref_error`
