#' Assess a cohort for the presence of dependency conflicts
#'
#' @export
#'
assess_has_dependency_conflict <- function(x, ...){
  UseMethod("assess_has_dependency_conflict")
}
attributes(assess_has_dependency_conflict)$column_name <- "dependency_conflict"
attributes(assess_has_dependency_conflict)$label <- "Cohort dependency conflicts"

#' @export
assess_has_dependency_conflict.cohort_ref <- function(x, ...){
  dep <- lapply(x$cohort, "[[", "dependencies")
  nm <- unlist(lapply(x$cohort, "[", "name"))

  nm_lib <- as_tibble(x$library)[, c(1:2)]

  dep <- data.frame(ref=rep(nm, sapply(dep, nrow)), bind_rows(dep))
  dep$version <- str_extract(dep$package, "(?<=\\().+(?=\\))")
  dep$version<- str_extract(dep$version, "\\d+\\.\\d+(\\.\\d+)*")
  dep$package <- trimws(gsub("\\(.+\\)", "", dep$package))
  dep2 <- list(minVer = tapply(dep$version, dep$package, function(x) sort(x, decreasing = T)[1]),
               minDep = tapply(dep$type, dep$package, function(x) sort(x)[1]))
  dep2 <- merge(as.data.frame(dep2$minVer), as.data.frame(dep2$minDep), by="row.names")

  lib <- rbind(nm_lib, data.frame(package=nm, version=unlist(lapply(x$cohort, "[", "version"))))
  dep3 <- merge(dep2, lib, by.x="Row.names", by.y="package", all.x = TRUE)
  dep3$conflict <- apply(dep3, 1, function(x) {
    if(is.na(x[4])){
      return(TRUE)
    } else if(is.na(x[2]) & !is.na(x[4])){
        return(FALSE)
      } else if (compareVersion(x[2],x[4])>0){
        return(TRUE)
      } else {
        return(FALSE)
          }
    })
  colnames(dep3) <- c("Pkg_dependency", "MinimumVersion","Type", "CurrentVersion", "IsConflict")
  cohort_metric_eval(class= "cohort_metric_dependency_conflict",
                     dep3[dep3$IsConflict, ])
}

#' Score a package for presence of dependency conflicts
#'
#' @return \code{1} if any dependencies are missing or conflicting, otherwise \code{0}
#'
#' @export
metric_score.cohort_metric_dependency_conflict <- function(x, ...) {
  as.numeric(NROW(x) > 0)
}

attributes(metric_score.cohort_metric_dependency_conflict)$label <-
  "A binary indicator of whether the cohort has missing or conflicting dependencies."
