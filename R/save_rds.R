#' save_rds
#'
#' A wrapper around saveRDS that returns the object invisibly for use in pipes
#'
#' @param object R object to serialize
#' @param ... additional arguments passed to saveRDS
#'
#' @details
#'
#' Saves an object as an RDS file
#'
#' @return
#' `object`
#'
#' @seealso
#'
#'  - [base::saveRDS()]
#'
#' @export

save_rds <- function( object, ... ) {

  saveRDS( object, ... )
  invisible(object)

}

