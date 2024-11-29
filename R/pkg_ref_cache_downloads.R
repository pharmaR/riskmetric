#' Cache a list of package download metrics from a package reference
#' @param n Number of days to look back with default value of 365 days
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
pkg_ref_cache.downloads <- function(x, ..., n=365) {
  UseMethod("pkg_ref_cache.downloads")
}

#' @importFrom cranlogs cran_downloads
pkg_ref_cache.downloads.pkg_ref <- function(x, ..., n=365) {
  downloads <- cran_downloads(x$name, from=Sys.Date()-n, to=Sys.Date())
  if (sum(downloads$count) == 0) {
    downloads <- bioc_downloads(x$name, from=Sys.Date()-n)
  }
  return(downloads)
}

#' @importFrom cranlogs cran_downloads
pkg_ref_cache.downloads.pkg_cran_remote <- function(x, ..., n=365) {
  cran_downloads(x$name, from=Sys.Date()-n, to=Sys.Date())
}

pkg_ref_cache.downloads.pkg_bioc_remote <- function(x, ..., n=365) {
  bioc_downloads(x$name, from=Sys.Date()-n)
}

#' @importFrom httr GET content
bioc_downloads <- function(pkg_name, from) {
  get_start_info <- function(n) {
    start_date <- from
    list(year = as.integer(format(start_date, "%Y")), month = as.integer(format(start_date, "%m")))
  }

  # Getting the start year and month
  start_info <- get_start_info(n)
  current_year <- as.integer(format(Sys.Date(), "%Y"))

  # Initialize results data frame
  results <- data.frame(date = as.Date(character()), count = integer(), package = character(), stringsAsFactors = FALSE)

  for (year in start_info$year:current_year) {
    url <- paste0("https://bioconductor.org/packages/stats/bioc/", pkg_name, "/", pkg_name, "_", year, "_stats.tab")

    tryCatch(
      {
        # Make the HTTP request
        response <- httr::GET(url)

        if (response$status_code == 404) {
          if (year == start_info$year) {
            months <- c(start_info$month:12)
          } else {
            months <- 1:12
          }
          for (month in months) {
            date <- as.Date(sprintf("%04d-%02d-01", year, month))
            results <- rbind(results, data.frame(date = date, count = 0, package = pkg_name, stringsAsFactors = FALSE))
          }
        } else {
          content <- httr::content(response, as = "text", encoding = "UTF-8")
          data <- read.delim(textConnection(content), sep = "\t", stringsAsFactors = FALSE)

          if (year == start_info$year) {
            months <- c(start_info$month:12)
            data <- data[data$Year == year & data$Month %in% month.abb[months], ]
          }

          # Handle missing Nb_of_downloads values
          data$Nb_of_downloads[is.na(data$Nb_of_downloads)] <- data$Nb_of_distinct_IPs[is.na(data$Nb_of_downloads)]

          for (i in seq_len(nrow(data))) {
            month_index <- match(data$Month[i], month.abb)
            if (!is.na(month_index)) {
              date <- as.Date(sprintf("%04d-%02d-01", data$Year[i], month_index))
              count <- data$Nb_of_downloads[i]
              results <- rbind(results, data.frame(date = date, count = count, package = pkg_name, stringsAsFactors = FALSE))
            }
          }
        }
      },
      error = function(e) {
        message("An error occurred while trying to read the file: ", e)
      }
    )
  }

  return(results)
}
