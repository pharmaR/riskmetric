pkg_res_cache.source_control_url <- function(url){
  url <- tolower(x$pkg_website)
  s_url <- "(github\\.com|bitbucket\\.org|gitlab\\.com)"

  if(! is.na(url)){
    res <- grep(s_url, strsplit(url, ",")[[1]], value = TRUE)
  }

  res
}
