% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assess_r_cmd_check.R
\name{assess_r_cmd_check}
\alias{assess_r_cmd_check}
\title{Assess a package's results from running R CMD check}
\usage{
assess_r_cmd_check(x, ...)
}
\arguments{
\item{x}{a \code{pkg_ref} package reference object}

\item{...}{additional arguments passed on to S3 methods, rarely used}
}
\value{
a \code{pkg_metric} containing Tally of errors, warnings and notes from running R CMD check locally
}
\description{
Assess a package's results from running R CMD check
}
\examples{
\dontrun{
assess_r_cmd_check(pkg_ref("riskmetric"))
}
}
\seealso{
\code{\link{metric_score.pkg_metric_r_cmd_check}}
}
