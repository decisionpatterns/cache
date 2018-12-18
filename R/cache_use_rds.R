#' Set the default cache method to rmat `RDS`.`
#'
#' Cache objects using RDS [base::saveRDS()]
#'
#' @details
#'
#' This is the *default* method for caching objects.
#'
#' `cache_use_rds` sets RDS as the default caching mechanism to use RDS.
#'
#' @examples
#'
#' \dontrun{
#'   cache_use_rds()
#' }
#'
#' @rdname cache_use_rds
#' @export

cache_use_rds <- function()
  cache::cache_backend("rds")


#' @rdname cache_use_rds
#' @export

cache_register_rds <- function()
  cache_register( "rds", writer = write_rds, reader = read_rds )


write_rds <- function( object, path, ... ) {
  saveRDS( object, file=path, ... )
  invisible(object)
}

read_rds <- readRDS
