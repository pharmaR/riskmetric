# riskmetric

[![Travis build status](https://travis-ci.org/pharmaR/riskmetric.svg?branch=master)](https://travis-ci.org/pharmaR/riskmetric)
[![Coverage status](https://codecov.io/gh/pharmaR/riskmetric/branch/master/graph/badge.svg)](https://codecov.io/github/pharmaR/riskmetric?branch=master)
 
`riskmetric` is a collection of risk metrics to evaluate the quality of R
packages.

_This package is in experimentation. Final considerations about design are being
considered, but core concepts are considered final._

## Background

The risk of using an R package is evaluated based on a number of metrics meant
to evaluate development best practices, code documentation, community engagement
and development sustainability. We hope to provide a framework to quantify risk
by assessing these metrics. This package serves as a starting point for
exploring the heterogeneity of code quality, and begin a broader conversation
about the validation of R packages. Primarily, this effort aims to provide some
context for validation within regulated industries.

We separate three steps in the workflow to assess the risk of an R package using `riskmetric`:

1. **Finding a source for package information (installed package or CRAN/git source)** `pkg_ref()`
1. **Assessing the package under validation criteria** `pkg_assess()`
1. **Scoring assessment criteria** `pkg_score()`
1. **Summarize scores into an aggregate risk metric** `summarize_scores()`

The results will be a datasets of validation criteria and its overall risk score for each package as
showin in the example below. 

## Installation

`riskmetric` is not yet on CRAN. Until it is, install it using `devtools`.

```r
devtools::install_github("pharmaR/riskmetric")
```

## Example

Scrape metadata locally or remotely, then assess that metadata and score it to
estimate risk. For each package, derive a composite measure of risk, or a
collection of individual scores which can be easily used to generate validation
reports.

```r
library(dplyr)
library(riskmetric)

pkg_ref(c("riskmetric", "utils", "tools")) %>%
  as_tibble() %>%
  pkg_assess() %>%
  pkg_score() %>%
  mutate(risk = summarize_scores(.))
```

## Get Involved

We have a bi-weekly sprint meeting for developer to discuss the progress.

* Contact `yilong.zhang@merck.com` to add into the meeting invitation. 
* Date: 1st and 3rd Wednesday of the month.
* Meeting Time: 12:00PM - 12:30PM EST
* [Project Planning Meeting Structure](https://github.com/pharmaR/riskmetric/issues/57) 
* [Milestone](https://github.com/pharmaR/riskmetric/milestones)
* [Meeting Room](https://merck.webex.com/join/zhanyilo)

`riskmetric` is centrally a community project. Comfort with a quantification of
risk comes via consensus, and for that this project is dependent on close
community engagement. There are plenty of ways to help:

- Share the package
- File [issues](https://github.com/pharmaR/riskmetric/issues) when you encounter bugs
- Weigh in on proposed metrics, or [suggest a new one](https://github.com/pharmaR/riskmetric/issues/new?labels=Metric%20Proposal)
- Help us devise the best way to summarize risk into a single score
- Help us keep documentation up to date
- Contribute code to tackle the metric backlog
