# Get Started

## Introduction

`riskmetric` provides a workflow to evaluate the quality of a set of R
packages that involves five major steps. The workflow can help users to
choose high quality R packages, improve package reliability and prove
the validity of R packages in a regulated industry. In concept, these
steps include:

#### 1. Finding a source for package information

First we need to identify a source of package metadata. There are a
number of places one may want to look for this information, be it a
source code directory, local package library or remote package
repository. Once we find a source of package data, we begin to collect
it in a *package reference* (`pkg_ref`) object.

> Learn more: [`?pkg_ref`](../reference/pkg_ref.md)

#### 2. Caching package metadata

If more information is needed to perform a given risk assessment, we
will use what metadata we already have to continue to search for more
fine-grained information about the package. For example, if we have a
location of a locally installed package, we can use that path to search
for that package’s `DESCRIPTION` file, and from there read in the
`DESCRIPTION` contents. To avoid repeatedly processing the same
metadata, these intermediate results are cached within the `pkg_ref`
object so that they can be used in the derivation of mulitple risk
metrics.

> Learn more:
> [`?pkg_ref_cache`](../reference/riskmetric_metadata_caching.md)

#### 3. Assess this metadata against a risk criterion

For each measure of risk, we first try to boil down that measure into
some fundamental nugget of the package metadata that is comparable
across packages and sources of information. The cross-comparable result
of assessing a package in this way is what we refer to as a *package
metric* (`pkg_metric`).

For example, with that `DESCRIPTION` file content, we might look at
whether a maintainer is identified in the authors list. To ensure we can
easily compare this information between packages that use the `Authors`
field and the `Authors@R` field, we would boil this information down to
just a single logical value indicating whether or not a maintainer was
identified.

> Learn more: [`?pkg_assess`](../reference/pkg_assess.md)

#### 4. Score our metrics

After we have these atomic representations of metrics, we want to score
them so that they can be meaningfully compared to one another. In
practice this just embeds a means of converting from the datatype of the
metric to a numeric value on a fixed scale from 0 (worst) to 1 (best).

Given our maintainer metric example, we might rate a package as `1`
(great) if a maintainer is identified or `0` (poor) if no maintainer is
found.

> Learn more: [`?pkg_score`](../reference/pkg_score.md)

#### 5. Summarizing across metric scores

Finally, we may want to look at these scores of individual metrics in
some sort of aggregate risk score. Naturally, not all metric scores may
warrant the same weight. Having scores normalized to a fixed range
allows us to define a summarizing algorithm to consistently assess and
compare packages.

Notably, risk is an inverse scale from metric scores. High metric scores
are favorable, whereas high risk scores are unfavorable.

> Learn more: [`?summarize_scores`](../reference/summarize_scores.md)

## The `riskmetric` Workflow

These five steps are broken down into just a handful of primary
functions.

![](../reference/figures/core-workflow.svg)

### Creating a package reference object

First, we create a *package reference* class object using the `pkg_ref`
constructor function. This object will contain metadata as it’s
collected in the various risk assessments.

``` r
library(riskmetric)
riskmetric_pkg_ref <- pkg_ref("riskmetric")
print(riskmetric_pkg_ref)
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

Here we see that the `riskmetric` `pkg_ref` object is actually
subclassed as a `pkg_install`. There is a hierarchy of `pkg_ref` object
classes including `pkg_source` for source code directories,
`pkg_install` for locally installed packages and `pkg_remote` for
references to package information pulled from the internet including
`pkg_cran_remote` and `pkg_bioc_remote` for CRAN and Bioconductor hosted
packages respectively.

Throughout all of `riskmetric`, S3 classes are used extensively to make
use of generic functions with divergent, reference mechanism dependent
behaviors for caching metadata, assessing packages and scoring metrics.

Likewise, some fields have a trailing `...` indicating that they haven’t
yet been computed, but that the reference type has knowledge of how to
go out and grab that information if the field is requested. Behind the
scenes, this is done using the `pkg_ref_cache` function, which itself is
an S3 generic, using the name of the field and `pkg_ref` class to
dispatch to appropriate functions for retrieving metadata.

### Assessing a package

There are a number of prespecified assessments, all prefixed by
convention with `assess_*`. Every assessment function takes a single
argument, a `pkg_ref` object and produces a `pkg_metric` object
corresponding to the `assess_*` function that was applied.

``` r
riskmetric_export_help_metric <- assess_export_help(riskmetric_pkg_ref)
print(riskmetric_export_help_metric[1:5])
```

    #>        assess_covr_coverage assessment_error_as_warning 
    #>                        TRUE                        TRUE 
    #>               as_pkg_metric             assess_has_news 
    #>                        TRUE                        TRUE 
    #>            score_error_zero 
    #>                        TRUE

Every function in the `assess_*` family of functions is expected to
return basic measure of a package. In this case, we return a named
logical vector indicating whether each export function has an associated
help document.

The return type also leaves a trail of what assessment produced this
metric. In addition to the `pkg_metric` class, we now have a
`pkg_metric_export_help` subclass which is used for dispatching to an
appropriate scoring method.

It’s worth pointing out that the act of calling this function has had
the side-effect of mutating our `riskmetric_pkg_ref` object.

``` r
riskmetric_pkg_ref
```

    #> <pkg_install, pkg_ref> riskmetric v0.2.5
    #> $help_aliases
    #>              riskmetric-package                          %||%
    #>                    "riskmetric"            "if_not_null_else"
    #>                          .tools                allow_mutation
    #>                     "dot-tools"              "allow_mutation"
    #>                 all_assessments   assessment_error_as_warning
    #>               "all_assessments" "assessment_error_as_warning"
    #>   <continued>
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
    #> $license...
    #> $maintainer...
    #> $news...
    #> $r_cmd_check...
    #> $release_date...
    #> $remote_checks...
    #> $source_control_url...
    #> $vignettes...
    #> $website_urls...

Here `riskmetric_pkg_ref$help_aliases` has a known value because it was
needed to asses whether the package has documentation for its exports.

> *a note on caching*
>
> This happens because `pkg_ref` objects are really just `environment`s
> with some syntactic sugar, and `environments` in R are always modified
> by-reference. This globally mutable behavior is used so that
> operations performed by one assessment can be reused by others.
> Likewise, computing one field may require that a previous field has
> been computed first, triggering a chain of metadata retrieval. In this
> case, `$help_aliases` required that `$path` be available.
>
> This chaining behavior comes for free by implementing the
> `pkg_ref_cache` caching function for each field. For contributors,
> this alleviates the need to remember an order of operations, and for
> users this behavior means that subsets of assessments can be run in an
> arbitrary order without pulling superfluous metadata, keeping track of
> every-growing objects or ensuring certain assessments get called
> before others.

In addition to the metric-specific `assess_*` family of functions, a
more comprehensive `pkg_assess` function is provided. Notably,
`pkg_assess` accepts a `pkg_ref` object and list of assessments to
apply, defaulting to
[`all_assessments()`](../reference/all_assessments.md), which returns a
list of all `assess_*` functions in the `riskmetric` namespace.

``` r
pkg_assess(riskmetric_pkg_ref)
```

    #> <list_of_pkg_metric[19]>
    #> $covr_coverage
    #> [1] NA
    #> attr(,"class")
    #> [1] "pkg_metric_na"            "pkg_metric_condition"    
    #> [3] "pkg_metric_covr_coverage" "pkg_metric"              
    #> [5] "logical"                 
    #> attr(,"label")
    #> [1] "Package unit test coverage"
    #> 
    #> $has_news
    #> [1] 1
    #> attr(,"class")
    #> [1] "pkg_metric_has_news" "pkg_metric"          "integer"            
    #> attr(,"label")
    #> [1] "number of discovered NEWS files"
    #> 
    #> $remote_checks
    #> [1] NA
    #> attr(,"class")
    #> [1] "pkg_metric_na"            "pkg_metric_condition"    
    #> [3] "pkg_metric_remote_checks" "pkg_metric"              
    #> [5] "logical"                 
    #> attr(,"label")
    #> [1] "Number of OS flavors that passed/warned/errored on R CMD check"
    #> 
    #> $news_current
    #> [1] FALSE
    #> attr(,"class")
    #> [1] "pkg_metric_news_current" "pkg_metric"             
    #> [3] "logical"                
    #> attr(,"label")
    #> [1] "NEWS file contains entry for current version number"
    #> 
    #> $r_cmd_check
    #> [1] NA
    #> attr(,"class")
    #> [1] "pkg_metric_na"          "pkg_metric_condition"   "pkg_metric_r_cmd_check"
    #> [4] "pkg_metric"             "logical"               
    #> attr(,"label")
    #> [1] "Package check results"
    #> 
    #> $exported_namespace
    #>  [1] "assess_covr_coverage"        "assessment_error_as_warning"
    #>  [3] "as_pkg_metric"               "assess_has_news"            
    #>  [5] "score_error_zero"            "assess_remote_checks"       
    #>  [7] "pkg_metric"                  "assess_news_current"        
    #>  [9] "assess_r_cmd_check"          "pkg_score"                  
    #> [11] "pkg_assess"                  "as_pkg_ref"                 
    #> [13] "score_error_NA"              "metric_score"               
    #> [15] "assess_exported_namespace"   "assess_has_vignettes"       
    #> [17] "assess_export_help"          "assess_has_website"         
    #> [19] "score_error_default"         "assessment_error_throw"     
    #> [21] "assess_has_maintainer"       "assess_last_30_bugs_status" 
    #> [23] "assess_size_codebase"        "all_assessments"            
    #> [25] "assess_has_source_control"   "assess_has_bug_reports_url" 
    #> [27] "assess_downloads_1yr"        "assess_reverse_dependencies"
    #> [29] "get_assessments"             "assess_has_examples"        
    #> [31] "summarize_scores"            "pkg_ref"                    
    #> [33] "assessment_error_empty"      "assess_dependencies"        
    #> [35] "assess_license"             
    #> 
    #> $has_vignettes
    #> [1] 0
    #> 
    #> $export_help
    #>        assess_covr_coverage assessment_error_as_warning 
    #>                        TRUE                        TRUE 
    #>               as_pkg_metric             assess_has_news 
    #>                        TRUE                        TRUE 
    #>            score_error_zero        assess_remote_checks 
    #>                        TRUE                        TRUE 
    #>                  pkg_metric         assess_news_current 
    #>                        TRUE                        TRUE 
    #>          assess_r_cmd_check                   pkg_score 
    #>                        TRUE                        TRUE 
    #>                  pkg_assess                  as_pkg_ref 
    #>                        TRUE                        TRUE 
    #>              score_error_NA                metric_score 
    #>                        TRUE                        TRUE 
    #>   assess_exported_namespace        assess_has_vignettes 
    #>                        TRUE                        TRUE 
    #>          assess_export_help          assess_has_website 
    #>                        TRUE                        TRUE 
    #>         score_error_default      assessment_error_throw 
    #>                        TRUE                        TRUE 
    #>       assess_has_maintainer  assess_last_30_bugs_status 
    #>                        TRUE                        TRUE 
    #>        assess_size_codebase             all_assessments 
    #>                        TRUE                        TRUE 
    #>   assess_has_source_control  assess_has_bug_reports_url 
    #>                        TRUE                        TRUE 
    #>        assess_downloads_1yr assess_reverse_dependencies 
    #>                        TRUE                        TRUE 
    #>             get_assessments         assess_has_examples 
    #>                        TRUE                        TRUE 
    #>            summarize_scores                     pkg_ref 
    #>                        TRUE                        TRUE 
    #>      assessment_error_empty         assess_dependencies 
    #>                        TRUE                        TRUE 
    #>              assess_license 
    #>                        TRUE 
    #> 
    #> $has_website
    #> [1] "https://pharmar.github.io/riskmetric/"
    #> [2] "https://github.com/pharmaR/riskmetric"
    #> 
    #> $has_maintainer
    #> [1] "Eli Miller <eli.miller@atorusresearch.com>"
    #> 
    #> $bugs_status
    #>  [1]  TRUE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE
    #> [13]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    #> [25]  TRUE FALSE FALSE  TRUE  TRUE  TRUE
    #> 
    #> $size_codebase
    #> <simpleError in attachNamespace(x$name): namespace is already attached>
    #> 
    #> $has_source_control
    #> [1] "https://github.com/pharmaR/riskmetric"
    #> 
    #> $has_bug_reports_url
    #> [1] 1
    #> attr(,"class")
    #> [1] "pkg_metric_has_bug_reports_url" "pkg_metric"                    
    #> [3] "integer"                       
    #> attr(,"label")
    #> [1] "presence of a bug reports url in repository"
    #> 
    #> $downloads_1yr
    #> [1] 5176
    #> 
    #> $reverse_dependencies
    #> character(0)
    #> 
    #> $has_examples
    #>   [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    #>  [16] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    #>  [31] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    #>  [46] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    #>  [61] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    #>  [76] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    #>  [91] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    #> [106] TRUE TRUE
    #> 
    #> $dependencies
    #>        package    type
    #> 1    backports Imports
    #> 2        utils Imports
    #> 3        tools Imports
    #> 4         xml2 Imports
    #> 5         httr Imports
    #> 6         curl Imports
    #> 7     urltools Imports
    #> 8      memoise Imports
    #> 9  BiocManager Imports
    #> 10    cranlogs Imports
    #> 11        covr Imports
    #> 12       vctrs Imports
    #> 13      pillar Imports
    #> 14      tibble Imports
    #> 15     pkgload Imports
    #> 16    devtools Imports
    #> 
    #> $license
    #> [1] "MIT + file LICENSE"

Since that is a lot to take in, `pkg_assess` also operates on `tibble`s,
returning a cleaner output that might be easier to sort through when
assessing a package.

``` r
pkg_assess(as_tibble(riskmetric_pkg_ref))
```

    #> # A tibble: 1 × 22
    #>   package    version pkg_ref             covr_coverage has_news   remote_checks
    #>   <chr>      <chr>   <lst_f_p_>          <lst_f_p_>    <lst_f_p_> <lst_f_p_>   
    #> 1 riskmetric 0.2.5   riskmetric<install> NA            1          NA           
    #> # ℹ 16 more variables: news_current <lst_f_p_>, r_cmd_check <lst_f_p_>,
    #> #   exported_namespace <lst_f_p_>, has_vignettes <lst_f_p_>,
    #> #   export_help <lst_f_p_>, has_website <lst_f_p_>, has_maintainer <lst_f_p_>,
    #> #   bugs_status <lst_f_p_>, size_codebase <lst_f_p_>,
    #> #   has_source_control <lst_f_p_>, has_bug_reports_url <lst_f_p_>,
    #> #   downloads_1yr <lst_f_p_>, reverse_dependencies <lst_f_p_>,
    #> #   has_examples <lst_f_p_>, dependencies <lst_f_p_>, license <lst_f_p_>

### Scoring package metrics

After a metric has been collected, we “score” the metric to convert it
to a quantified representation of risk.

There is a single scoring function, `metric_score`, that dispatches
based on the class of the metric that is passed to it to interpret the
atomic metric result.

``` r
metric_score(riskmetric_export_help_metric)
#> [1] 1
```

For convenience, `pkg_score` is provided as a convenience to operate on
`pkg_ref` objects directly. It can also operate on the `tibble` produced
by `pkg_assess` applied to a `pkg_ref` `tibble`, providing a new
`tibble` with scored metrics.

``` r
pkg_score(pkg_assess(as_tibble(pkg_ref("riskmetric"))))
#> # A tibble: 1 × 23
#>   package    version pkg_ref             pkg_score covr_coverage has_news  
#>   <chr>      <chr>   <lst_f_p_>              <dbl> <pkg_scor>    <pkg_scor>
#> 1 riskmetric 0.2.5   riskmetric<install>     0.564 NA            1         
#> # ℹ 17 more variables: remote_checks <pkg_scor>, news_current <pkg_scor>,
#> #   r_cmd_check <pkg_scor>, exported_namespace <pkg_scor>,
#> #   has_vignettes <pkg_scor>, export_help <pkg_scor>, has_website <pkg_scor>,
#> #   has_maintainer <pkg_scor>, bugs_status <pkg_scor>,
#> #   size_codebase <pkg_scor>, has_source_control <pkg_scor>,
#> #   has_bug_reports_url <pkg_scor>, downloads_1yr <pkg_scor>,
#> #   reverse_dependencies <pkg_scor>, has_examples <pkg_scor>, …
```

> Note that `pkg_assess` and `pkg_score` accepts an `error_handler`
> argument which determines how errors are escalated for communication.
> We’ve chosen to default to being cautious, displaying warnings
> liberally to ensure thorough documentation of the risk assessment
> process. If these warnings are bothersome, there are alternative
> reporting schemes in the `assessment_error_*` and `score_error_*`
> families of functions.

## Cohort assessments

Packages are often part of a larger cohort, so we’ve made sure to
accommodate assessments of mulitple packages simultaneously.

### Creating a `tibble` from `pkg_ref`s

We start by calling our `pkg_ref` constructor function with a list or
vector. Doing so will return a list of `pkg_ref` objects. With this
list, we can use
[`tibble::as_tibble`](https://tibble.tidyverse.org/reference/as_tibble.html)
to convert the `pkg_ref` list into a `tibble`, automatically populating
some useful index columns like `package` and `version`. To clean things
up further we can use the `magrittr` pipe (`%>%`) to chain these
commands together.

``` r
package_tbl <- pkg_ref(c("riskmetric", "utils", "tools")) %>%
  as_tibble()
```

### The `riskmetric` workflow on multiple packages

`pkg_assess` and `pkg_score` can operate on `tibble`s, making it easy to
simultaneously test an entire cohort of packages at once.

``` r
package_tbl %>%
  pkg_assess() %>%
  pkg_score()
#> # A tibble: 3 × 23
#>   package    version pkg_ref             pkg_score covr_coverage has_news  
#>   <chr>      <chr>   <lst_f_p_>              <dbl> <pkg_scor>    <pkg_scor>
#> 1 riskmetric 0.2.5   riskmetric<install>     0.564 NA            1         
#> 2 utils      4.5.2   utils<install>          0.687 NA            0         
#> 3 tools      4.5.2   tools<install>          0.735 NA            0         
#> # ℹ 17 more variables: remote_checks <pkg_scor>, news_current <pkg_scor>,
#> #   r_cmd_check <pkg_scor>, exported_namespace <pkg_scor>,
#> #   has_vignettes <pkg_scor>, export_help <pkg_scor>, has_website <pkg_scor>,
#> #   has_maintainer <pkg_scor>, bugs_status <pkg_scor>,
#> #   size_codebase <pkg_scor>, has_source_control <pkg_scor>,
#> #   has_bug_reports_url <pkg_scor>, downloads_1yr <pkg_scor>,
#> #   reverse_dependencies <pkg_scor>, has_examples <pkg_scor>, …
```

Notice that a summary column, `pkg_score`, is included in addition to
our metric scores. This value is a shorthand for aggregating a weighted
average of risk scores across `tibble` columns using `summarize_scores`.

``` r
package_tbl %>%
  pkg_assess() %>%
  pkg_score() %>%
  summarize_scores()
#> [1] 0.5635860 0.6870884 0.7354773
```

## How you can help…

As you can see, the package is currently quite bare-bones and nobody
would reasonably choose packages based solely on the existence of a NEWS
file.

Our priority so far has been to set up an extensible framework as the
foundation for a community effort, and that’s where you come in! There
are a few things you can do to get started.

1.  [Propose a new metric on the `riskmetric`
    GitHub](https://github.com/pharmaR/riskmetric/issues/new?labels=Metric%20Proposal)
2.  [Take part in the
    discussion](https://github.com/pharmaR/riskmetric/issues?q=is%3Aopen+is%3Aissue+label%3A%22Metric+Proposal%22)
    about which metrics are captured and how they are measured
3.  Check out the `extending-riskmetric` vignette to see how to extend
    the functionality with your own metrics where we can further discuss
    new metric proposals
4.  Help us to develop new metrics and package functionality
