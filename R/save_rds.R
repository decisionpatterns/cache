#' save_rds
#'
#' A wrapper around [base::saveRDS()] that returns the object invisibly for
#' use in pipes
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
#'  - readr::write_rds
#'
#' @export

save_rds <- function( object, ... ) {

  saveRDS( object, ... )
  invisible(object)

}

write_rds <- save_rds

read_rds <- readRDS
