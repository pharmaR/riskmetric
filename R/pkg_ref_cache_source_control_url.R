pkg_res_cache.source_control_url <- function(url){
  url <- tolower(x$pkg_website)
  s_url <- c("github.com", "bitbucket.com", "gitlab.com")

  if(! is.na(url)){
    res <- list()
    for(i in 1:length(s_url)){
      res[[i]] <- grep(s_url[i], unlist(strsplit(url, ",")), value = TRUE)
    }
    res <- unlist(res)
  }

  res
}
