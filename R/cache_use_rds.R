#' Cache object using RDS Files
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
#'   cache_use_rds
#' }
#'
#' @rdname cache_use_rds
#' @export

cache_use_rds <- function()
  cache::backend_set("rds")


#' @rdname cache_use_rds
#' @export

cache_register_rds <- function()
  backend_register( "rds", writer = write_rds, reader = read_rds )

  # options( cache.write = cache_write_rds, cache.read = cache_read_rds )

write_rds <- function( object, path, ... ) {
  saveRDS( object, file=path, ... )
  object
}

# write_rds <- save_rds

read_rds <- readRDS



#' #' @param object; object to cache
#' #' @param name string; name of object.
#' #' @param cache path to the cache directory
#' #' @param ... additional arguments passed to [write_rds()] / [base::saveRDS()]
#' #'
#' #' @details
#' #'
#' #' The `cache_write_rds` writes objects to the cache using RDS
#' #'
#' #' @examples
#' #'
#' #' dontrun{
#' #'    cache_use_rds()
#' #'    cache(mtcars)
#' #'    if( exists('mtcars') ) rm(mtcars)
#' #'    uncache(mtcars)
#' #'    fs::dir_ls( cache_find() )
#' #' }
#' #'
#' #' @rdname cache_use_rds
#' #' @export
#'
#' cache_write_rds <- write_rds
#'
#' # function(
#' #     object
#' #   , path
#' #   # , name = deparse(substitute(object))
#' #   # , cache=cache_find()
#' #   , ...
#' # ) {
#' #
#' #   save_rds( object, path, ... )
#' #
#' # }
#'
#'
#' #' @rdname cache_use_rds
#' #' @export
#'
#' cache_read_rds <- read_rds
#' # function(path, ...) { # name, cache=find_cache(), ... ) {
#' #
#' #   readRDS(path, ...)
#' #
#' # }
