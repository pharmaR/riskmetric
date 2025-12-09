# Document both declare_cache_behavior parameters and options list

Document both declare_cache_behavior parameters and options list

## Usage

``` r
roxygen_cache_behaviors(
  fmt = "%s: %s",
  name_fmt = "%s",
  annotation_fmt = "%s",
  wrap_fmt = "%s",
  collapse = "\n"
)
```

## Arguments

- fmt:

  format of cache behavior entries

- name_fmt:

  special formating for name (first) component

- annotation_fmt:

  special formating for annotation (second) component

- wrap_fmt:

  a wrapper for the entirety of the roxygen entries

- collapse:

  passed to paste

## Value

a string
