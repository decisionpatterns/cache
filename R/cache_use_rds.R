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

cache_register_rds <- function()
  cache_register_backend( "rds", write = cache_write_rds, read = cache_read_rds )

  # options( cache.write = cache_write_rds, cache.read = cache_read_rds )


#' @param object; object to cache
#' @param name string; name of object.
#' @param cache path to the cache directory
#' @param ... additional arguments passed to [save_rds()] / [base::saveRDS()]
#'
#' @details
#'
#' The `cache_write_rds` writes objects to the cache using RDS
#'
#' @examples
#'
#' dontrun{
#'    cache_use_rds()
#'    cache(mtcars)
#'    if( exists('mtcars') ) rm(mtcars)
#'    uncache(mtcars)
#'    fs::dir_ls( cache_find() )
#' }
#'
#' @rdname cache_use_rds
#' @export

cache_write_rds <- function(
    object
  , name = deparse(substitute(object))
  , cache=cache_find()
  , ...
) {

  path <- {
    fs::path( cache, name ) ->.;
    paste0( . , ".rds")             # can't use path_set_ext because it modifies last .xyz
  }

  save_rds( object, file=path, ... )

}


#' @rdname cache_use_rds
#' @export

cache_read_rds <- function( name, cache=find_cache(), ... ) {

  path <- {
    fs::path( cache, name ) ->.;
    fs::path_ext_set(. , "rds")
  }

  readRDS(path)

}
