# riskmetric

[![R build status](https://github.com/pharmaR/riskmetric/workflows/R-CMD-check/badge.svg)](https://github.com/pharmaR/riskmetric/actions?workflow=R-CMD-check)
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

The results will be assembled in a dataset of validation criteria containing an
overall risk score for each package as shown in the example below.

## Installation

You can install `riskmetric`  from CRAN with:

```r
install.packages("riskmetric")
```

Or from GitHub using `devtools` with:

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
  pkg_assess() %>%
  pkg_score()
```

## Get Involved

We have a bi-weekly sprint meeting for developers to discuss the progress.

* Contact `eric.milliman@biogen.com` to be added to the meeting.
* [Project Planning Meeting Structure](https://github.com/pharmaR/riskmetric/issues/57) 
* [Milestone](https://github.com/pharmaR/riskmetric/milestones)

`riskmetric` is centrally a community project. Comfort with a quantification of
risk comes via consensus, and for that this project is dependent on close
community engagement. There are plenty of ways to help:

- Share the package
- File [issues](https://github.com/pharmaR/riskmetric/issues) when you encounter bugs
- Weigh in on proposed metrics, or [suggest a new one](https://github.com/pharmaR/riskmetric/issues/new?labels=Metric%20Proposal)
- Help us devise the best way to summarize risk into a single score
- Help us keep documentation up to date
- Contribute code to tackle the metric backlog
