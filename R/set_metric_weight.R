#' Function to conviently set the weights for a subset of package metrics
#'
#' Sometimes you want to change one or a few metric weights while keeping the rest the same,
#' instead of having to define all weights this function will let you set the weight of
#' specific metrics while returning the default weight for the rest of the metrics not named.
#'
#' @param data `pkg_assess` object
#' @param weight named vector of assessment(s) and their weight(s)
#'
#' @return A named vector of package metrics and their weights
#'
#' @export
set_metric_weight <- function(data, weight){

  default_weights <- add_default_weights(data)
  if(any(!names(weight) %in% names(default_weights))){
    warning("One or more of the weights you specified do not have a corresponding metric function and will be ignored")
    weight <- weight[names(weight) %in% names(default_weights)]
  }

  default_weights[names(weight)] <- weight
  return(default_weights)
}
