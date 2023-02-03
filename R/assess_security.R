#' Assess a package for known security vulnerabilities in the OSS Index
#'
#' @eval roxygen_assess_family(
#'   "security",
#'   "Assess for any known security vulnerabilities in the OSS Index via oysteR",
#'   dontrun = TRUE)

#' @export
assess_security <- function(x, ...) {
  # TODO: discuss preferred approach for handling packages within Suggests
  if (!requireNamespace("oysteR", quietly = TRUE)) {
    if (interactive()) {
      inst_yn <- menu(
        choices = c("Yes", "No"),
        title = paste(
          "Assessing security requires installation of the oyster package.",
          "Would you like to install this now?"
        )
      )

      if (inst_yn == "1") {
        install.packages("oysteR")
      } else {
        stop(
          paste(
            "asssess_security not run. Please install the oysteR package if you", "
        wish to assess security."
          )
        )
      }
    }
  }

  UseMethod("assess_security")
}

attributes(assess_security)$column_name <- "security"
attributes(assess_security)$label <- "OSS Scan Results"


#' @export
assess_security.default <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_security", {
    x$security
  })
}


#' Score a package for known security vulnerabilities in the OSS Index
#'
#' Coerce the count of reported vulnerabilities to a binary indicator.
#'
#' @eval roxygen_score_family("security", dontrun = TRUE)
#' @return A weighted sum of errors and warnings of all tests preformed
#'
#' @export
metric_score.pkg_metric_security <- function(x, ...) {
  as.numeric(x > 0)
}
attributes(metric_score.pkg_metric_security)$label <-
  "A binary indicator of whether a package has OSS Index listed vulnerabilities."
