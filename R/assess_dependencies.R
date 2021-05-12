assess_reverse_dependencies <- function(x, ...){
  return(nrow(x$revdeps))

}

assess_total_dependencies <- function(x, ...){
  return(table(x$deps$type[!grepl("^R ", x$deps$package)]))
}

assess_new_dependencies <- function(x, ...){
  ip <- memoise_installed_packages()
  newDeps <- x$deps[!gsub("\\(.+\\)","", x$deps$package) %in% rownames(ip), ]
  return(table(newDeps$type[!grepl("^R ", newDeps$package)]))
}
