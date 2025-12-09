# Walk the pkg_ref class hierarchy to match a single subclass to a class path

Walk the pkg_ref class hierarchy to match a single subclass to a class
path

## Usage

``` r
get_pkg_ref_classes(x, classes = pkg_ref_class_hierarchy)
```

## Arguments

- x:

  (\`character(1L)\`) A subclass, among those known in pkg_ref
  subclasses

- classes:

  (\`list\`) A class hierarchy, described using a named list. Defaults
  to \`pkg_ref_class_hierarchy\`.

## Value

A \`character(n)\` class path from \`pkg_ref\` down to the specified
subclass, or \`FALSE\` if no path is found.
