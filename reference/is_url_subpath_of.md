# check if a url originates from a list of repo urls

check if a url originates from a list of repo urls

## Usage

``` r
is_url_subpath_of(url, urls)
```

## Arguments

- url:

  a url which may stem from one of the provided base urls

- urls:

  vector of base urls

## Value

logical vector indicating which base urls have a sub url of `url`
