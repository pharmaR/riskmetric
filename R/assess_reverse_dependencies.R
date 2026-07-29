#' Generate list of Reverse Dependencies for a package
#'
#' @details The more packages that depend on a package the more chance
#' for errors/bugs to be found.
#'
#' The default method computes the reverse-dependency list from an
#' available-packages index (typically the CRAN and/or Bioconductor
#' \code{PACKAGES} files reachable via \code{getOption("repos")}). This
#' avoids the historical dependency on \code{devtools::revdep(bioconductor = TRUE)},
#' which unconditionally reads a \code{VIEWS} file from
#' \code{BiocManager::repositories()[["BioCsoft"]]}. That read fails in
#' air-gapped environments (for example, an internal Posit Package
#' Manager mirror that serves \code{<repo>/src/contrib/PACKAGES} but no
#' \code{<repo>/VIEWS}), which caused the reverse-dependencies metric to
#' silently degrade to a \code{pkg_metric_error} for every package in
#' the run.
#'
#' Callers on the public network get the same result as before — the
#' default \code{repos} value picks up whatever CRAN / Bioconductor
#' mirrors are already configured — while callers on internal mirrors
#' can point \code{repos} at those mirrors (or set
#' \code{options(repos = ...)} once at the top of the session) and
#' expect the metric to populate correctly.
#'
#' @eval roxygen_assess_family(
#'   "reverse_dependencies",
#'   "A character vector of reverse dependencies")
#'
#' @param repos Character vector of repository URLs to consult when
#'   building the available-packages index. Defaults to
#'   \code{getOption("repos")}. Ignored when \code{available} is
#'   supplied.
#' @param dependencies Character vector of dependency types to consider
#'   when computing reverse dependencies. Defaults to
#'   \code{c("Depends", "Imports", "LinkingTo", "Suggests")} to match
#'   the previous \code{devtools::revdep()} behaviour.
#' @param available Optional pre-computed matrix returned by
#'   \code{\link[utils]{available.packages}}. Supplying it avoids a
#'   repeated network fetch when the metric is computed for many
#'   packages in the same session.
#'
#' @export
assess_reverse_dependencies <- function(x, ...) {
  UseMethod("assess_reverse_dependencies")
}

#' @rdname assess_reverse_dependencies
#' @export
assess_reverse_dependencies.default <- function(
  x,
  ...,
  repos        = getOption("repos"),
  dependencies = c("Depends", "Imports", "LinkingTo", "Suggests"),
  available    = NULL
) {
  pkg_metric_eval(
    class = "pkg_metric_reverse_dependencies",
    {
      ap <- if (is.null(available)) {
        utils::available.packages(repos = repos)
      } else {
        available
      }
      revs <- tools::dependsOnPkgs(
        x$name,
        dependencies = dependencies,
        recursive    = FALSE,
        installed    = ap
      )
      sort(unique(as.character(revs)))
    }
  )
}

attr(assess_reverse_dependencies, "column_name") <- "reverse_dependencies"
attr(assess_reverse_dependencies, "label") <- "List of reverse dependencies a package has"

#' Scoring method for number of reverse dependencies a package has
#'
#' Score a package for the number of reverse dependencies it has; regularized
#' Convert the number of reverse dependencies \code{length(x)} into a validation
#' score [0,1] \deqn{ 1 / (1 + exp(-0.5 * (sqrt(length(x)) + sqrt(5)))) }
#'
#' The scoring function is the classic logistic curve \deqn{
#' 1 / (1 + exp(-k(x-x[0])) } with a square root scale for the number of reverse dependencies
#' \eqn{x = sqrt(length(x))}, sigmoid midpoint is 5 reverse dependencies, ie. \eqn{x[0] =
#' sqrt(5)}, and logistic growth rate of \eqn{k = 0.5}.
#'
#' \deqn{ 1 / (1 + -0.5 * exp(sqrt(length(x)) - sqrt(5))) }

#' @eval roxygen_score_family("reverse_dependencies", dontrun = TRUE)
#' @return numeric value between \code{1} (high number of reverse dependencies) and
#'   \code{0} (low number of reverse dependencies)
#'
#' @export
metric_score.pkg_metric_reverse_dependencies <- function(x,...){
  1 / (1 + exp(-0.5 * (sqrt(length(x)) - sqrt(5))))
}

attributes(metric_score.pkg_metric_reverse_dependencies)$label <-
  "The (log10) number of packages that depend on this package."

