# Extending riskmetric

`riskmetric` is designed to be readily extensible. This is done through
use of the S3 method dispatch system and a conscious acknowledgement of
the varying needs that someone may have when assessing package risk.
With this in mind, every user-facing function is designed first and
foremost to be flexible.

Here we’ll walk through a trivial example where we’ll extend
`riskmetric` to add a new assessment, scoring and risk summary function
to determine the risk associated with a package given its name starts
with the letter “r”.

## Package Classes

Before we can assess a package we first need to represent a package as
data. We refer to this collection of package metadata as a “package
reference” - a way of referring to the related information we’ve been
able to pull together about a package. This is represented as a
`pkg_ref` class object. As dimensions of risk are assessed, the data
needed to evaluate it in those terms is cached within this object,
building up a small store of information about the package which other
assessments can refer to or build off of.

Importantly, not all references to packages are equal. We can collect
information given the source code, a locally installed package or by
scraping data about a package from the web. There’s a hierarchy of
subclasses that encapsulate these disparate use cases.

    pkg_ref
     ├─ pkg_source
     ├─ pkg_install
     └─ pkg_remote
         ├─ pkg_cran_remote
         └─ pkg_bioc_remote

These subclasses direct the behavior of all downstream operations and
provides flexibility about how to bucket the implementations of how
similar data can be collected from a number of potential sources. For
example, to determine the author of a package it would be easiest to
look at a package’s `DESCRIPTION` file where this content is maintained.
However, without access to the source or installed files, one could find
the same information on the CRAN package webpage. Using these
subclasses, the appropriate method of collecting this data can be
selected.

## Adding an Assessment

Assessments are the atomic unit of the `riskmetric` package, and are
used to kick off an individual metric evaluation. Each assessment is a
generic function starting with an `assess_` prefix, which can dispatch
based on the subclass of the `pkg_ref` object.

### Assessment Example

As an example, take a look at how `assess_has_news` has been
implemented. We’ll focus on just the generic and the `pkg_install`
functions:

    #> assess_has_news <- function (x, ...) 
    #> {
    #>     UseMethod("assess_has_news")
    #> }
    #> attr(,"column_name")
    #> [1] "has_news"
    #> attr(,"label")
    #> [1] "number of discovered NEWS files" 
    #> 
    #> assess_has_news.pkg_install <- NULL

There are a couple things to note. First, the S3 system is used to
dispatch functionality for the appropriate package reference class.
Since the way we’d assess the inclusion of a NEWS file might be
different for an installed package or remotely sourced metadata, we may
have separate functions to process these datatypes in distinct ways.

Second, for each assessment, a `pkg_metric` object is returned. This
stores the atomic data pertaining to the metric and importantly adopts a
unique subclass for the assessment function.

Finally, a cosmetic `"column_name"` attribute is tagged to the function.
This is used when calling the `assess` function. The `assess` verb is a
convenience function which steps through all available assessments
returning a `tibble` of assessment outputs. The `"column_name"` provides
a more user-friendly label for the assessment in this `tibble`.

### Writing a New Assessment

Now we’ll write our assessment. Eventually we want to consider a package
high risk if the name does not start with “r”. We’ll need to make a
`pkg_metric` object containing the first letter of the name.

``` r
assess_name_first_letter <- function(x, ...) {
  UseMethod("assess_name_first_letter")
}
attr(assess_name_first_letter, "column_name") <- "name_first_letter"

assess_name_first_letter.pkg_ref <- function(x, ...) {
  pkg_metric(substr(x$name, 0, 1), class = "pkg_metric_name_first_letter")
} 
```

## Adding `pkg_ref` Metadata

Perhaps we want to reuse metadata used when assessing the first letter
so that it can be reused by other assessments. For particularly taxing
metadata, such as metadata that requires a query against a public API,
scraping a web page or a large data download, it’s important to store it
for other assessment functions to reuse.

To handle this, we define a function for `pkg_ref_cache` to dispatch to.

### Example Metadata Caching

This is how the `riskmetric` package handles parsing the DESCRIPTION
file so that it can feed into all downstream assessments without having
to re-parse the file each time or copy the code to do so.

    #> pkg_ref_cache.description <- function (x, name, ...) 
    #> {
    #>     UseMethod("pkg_ref_cache.description")
    #> } 
    #> 
    #> pkg_ref_cache.description.pkg_install <- function (x, name, ...) 
    #> {
    #>     read.dcf(file.path(x$path, "DESCRIPTION"))
    #> }

Once these are defined, they’ll be automatically called when the field
is first accessed by the `pkg_ref` object, and then stored for any
downstream uses.

``` r
library(riskmetric)
package <- pkg_ref("riskmetric")
```

    #> <pkg_install, pkg_ref> riskmetric v0.2.5
    #> $path
    #>   [1] "/home/user/username/R/4.5/Resources/library/riskmetric"
    #> $source
    #>   [1] "pkg_install"
    #> $version
    #>   [1] '0.2.5'
    #> $name
    #>   [1] "riskmetric"
    #> $bug_reports...
    #> $bug_reports_host...
    #> $bug_reports_url...
    #> $description...
    #> $downloads...
    #> $examples...
    #> $help...
    #> $help_aliases...
    #> $license...
    #> $maintainer...
    #> $news...
    #> $r_cmd_check...
    #> $release_date...
    #> $remote_checks...
    #> $source_control_url...
    #> $vignettes...
    #> $website_urls...

Notice that upon initialization, the `description` field indicates that
it hasn’t yet been evaluated with a trailing `...` in the name. When
accessed, the object will call a caching function to go out and grab the
package metadata and return the newly derived value.

``` r
package$description
```

Because the `pkg_ref` object stores an environment, caching this value
once makes them available for any future attempts to access the field.
This is helpful because we, as developers of the package, don’t need to
think critically about the order that assessments are performed, and
allows users to redefine the order of assessments without worry about
how metadata is acquired.

### Writing a Metadata Cache

Now, for our new metric, we want to cache the package name’s first
letter. We need to add a new `pkg_ref_cache` function for our field.
Thankfully, any subclass of `pkg_ref` can access the first letter the
same way, so we just need the one function.

``` r
pkg_ref_cache.name_first_letter <- function(x, name, ...) {
  substr(x$name, 0, 1)
}
```

After adding this caching function, we need to make a small modification
to `assess_name_first_letter.pkg_ref` in order use our newly cached
value.

``` r
assess_name_first_letter.pkg_ref <- function(x, ...) {
  pkg_metric(x$name_first_letter, class = "pkg_metric_name_first_letter")
} 
```

Let’s try it out!

``` r
package$name
#> [1] "riskmetric"
package$name_first_letter
#> [1] "r"
```

## Defining an Assessment Scoring Function

Next, we need a function for scoring our assessment output. In this
case, our output is a `pkg_metric` object whose data is the first letter
of the package name.

We’ll add a dispatched function for the `score` function. As a
convention, these functions return a numeric value representing how well
the package conforms to best practices with values between 0 (poor
practice) and 1 (best practice).

``` r
metric_score.pkg_metric_name_first_letter <- function(x, ...) {
  as.numeric(x == "r")
}
```

## Adding our Assessment to the `pkg_assess()` Verb

The `assess` function accepts a list of functions to apply. `riskmetric`
provides a shorthand,
[`all_assessments()`](../reference/all_assessments.md), to collect all
the included assessment functions, and you’re free to add to that list
to customize your own assessment toolkit.

``` r
library(dplyr)
assessments <- pkg_ref(c("riskmetric", "utils", "tools")) %>%
  as_tibble() %>%
  pkg_assess(c(all_assessments(), assess_name_first_letter))
assessments
#> # A tibble: 3 × 23
#>   package    version pkg_ref             covr_coverage has_news   remote_checks
#>   <chr>      <chr>   <lst_f_p_>          <lst_f_p_>    <lst_f_p_> <lst_f_p_>   
#> 1 riskmetric 0.2.5   riskmetric<install> NA            1          NA           
#> 2 utils      4.5.2   utils<install>      NA            0          NA           
#> 3 tools      4.5.2   tools<install>      NA            0          NA           
#> # ℹ 17 more variables: news_current <lst_f_p_>, r_cmd_check <lst_f_p_>,
#> #   exported_namespace <lst_f_p_>, has_vignettes <lst_f_p_>,
#> #   export_help <lst_f_p_>, has_website <lst_f_p_>, has_maintainer <lst_f_p_>,
#> #   bugs_status <lst_f_p_>, size_codebase <lst_f_p_>,
#> #   has_source_control <lst_f_p_>, has_bug_reports_url <lst_f_p_>,
#> #   downloads_1yr <lst_f_p_>, reverse_dependencies <lst_f_p_>,
#> #   has_examples <lst_f_p_>, dependencies <lst_f_p_>, license <lst_f_p_>, …
```

Our scoring function will automatically get picked up and used by the
score method.

``` r
pkg_score(assessments)
#> # A tibble: 3 × 24
#>   package    version pkg_ref             pkg_score covr_coverage has_news  
#>   <chr>      <chr>   <lst_f_p_>              <dbl> <pkg_scor>    <pkg_scor>
#> 1 riskmetric 0.2.5   riskmetric<install>     0.535 NA            1         
#> 2 utils      4.5.2   utils<install>          0.703 NA            0         
#> 3 tools      4.5.2   tools<install>          0.748 NA            0         
#> # ℹ 18 more variables: remote_checks <pkg_scor>, news_current <pkg_scor>,
#> #   r_cmd_check <pkg_scor>, exported_namespace <pkg_scor>,
#> #   has_vignettes <pkg_scor>, export_help <pkg_scor>, has_website <pkg_scor>,
#> #   has_maintainer <pkg_scor>, bugs_status <pkg_scor>,
#> #   size_codebase <pkg_scor>, has_source_control <pkg_scor>,
#> #   has_bug_reports_url <pkg_scor>, downloads_1yr <pkg_scor>,
#> #   reverse_dependencies <pkg_scor>, has_examples <pkg_scor>, …
```

and we can define our own summarizing weights by passing a named list to
`pkg_score`.

``` r
pkg_score(assessments, weights = c(has_website = 1, name_first_letter = 1))
#> # A tibble: 3 × 24
#>   package    version pkg_ref             pkg_score covr_coverage has_news  
#>   <chr>      <chr>   <lst_f_p_>              <dbl> <pkg_scor>    <pkg_scor>
#> 1 riskmetric 0.2.5   riskmetric<install>         0 NA            1         
#> 2 utils      4.5.2   utils<install>              1 NA            0         
#> 3 tools      4.5.2   tools<install>              1 NA            0         
#> # ℹ 18 more variables: remote_checks <pkg_scor>, news_current <pkg_scor>,
#> #   r_cmd_check <pkg_scor>, exported_namespace <pkg_scor>,
#> #   has_vignettes <pkg_scor>, export_help <pkg_scor>, has_website <pkg_scor>,
#> #   has_maintainer <pkg_scor>, bugs_status <pkg_scor>,
#> #   size_codebase <pkg_scor>, has_source_control <pkg_scor>,
#> #   has_bug_reports_url <pkg_scor>, downloads_1yr <pkg_scor>,
#> #   reverse_dependencies <pkg_scor>, has_examples <pkg_scor>, …
```

Of course you can do any downstream processing of the resulting `tibble`
if you’d like to further fine-tune your summarization using a nonlinear
function.

## How you can help…

The `riskmetric` package was designed to be easily extensible. You can
develop dispatched functions in your development environment, hone them
into well formed assessments and contribute them back to the core
`riskmetric` package once you’re done.

If you’d like feedback before embarking on developing a new metric,
please feel free to [file an issue on the riskmetric
GitHub](https://github.com/pharmaR/riskmetric/issues/new?labels=Metric%20Proposal).
