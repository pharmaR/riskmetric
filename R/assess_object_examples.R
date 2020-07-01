#' Assess a package for examples of exported objects
#'
#' @eval roxygen_assess_family(
#'   "export_object_examples",
#'   "a logical vector indicating existence of an example for exported objects")
#'
#' @export

assess_object_examples <- function(x, ...){
  UseMethod("assess_object_examples")

}

