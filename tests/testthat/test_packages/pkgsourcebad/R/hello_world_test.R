#' A Test function
#'
#' @param x An object to print
#'
#' @return Nothing
#' @export
hello_world_test <- function(x) {
  print(paste0("hello world", x))
}

#' A Test Function with no help docs
#' @export
#' @noRd
hello_work_test_2 <- function(x) {
  print(paste0("hello world", x))
}
