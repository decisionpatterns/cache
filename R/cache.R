#' Cache and uncache an object
#'
#' Caches or uncaches and object in a cache directory
#'
#' @param object object to cache
#' @param name string; name for the object defaults to the
#'   `default(substitute(object))`
#' @param cache character; path to cache directory. The default is
#'        `getOption('cache')` or else simply `cache`
#' @param timestamp string or function (of 0 arguments); timestamp to add to
#'        the filename.
#' @param envir environment .. where object to cache or to where object should
#'        be uncached. Defaults to the caller's environment
#' @param overwrite logical; whether to overwrite if it `name` already exists
#'        on the environment.
#' @param ... additional arguments
#' @param fun functiontion for writing or reading the objects. Defaults to
#' [cache_write_rds()]
#'
#' `cache`/`cache_` and `uncache`/`uncache_` save and restore single objects to
#' the a `cache` directory.
#'
#' The `cache` defaults to the global option 'cache' otherwise
#' the `cache` in the working directory is used. This follows the behavior
#' in the *ProjectTemplate* package.
#'
#' `uncache_all` restores all files in a cache directory.
#'
#' `cache` also allows for timestamps. The default is to use the global
#' option `timestamp`. This can either be a character vector or a function
#' of zero arguments that returns an unary length character vector. (Only the
#' first value is used.)  Common practice is to use `Sys.Date` or
#' `Sys.time` for creating the timestamp.
#'
#' The writing of files is delegated to `cache_write_x` functions ...
#'
#' @seealso
#'   `base::saveRDS` \cr
#'
#' @examples
#'
#'   \dontrun{
#'      data(mtcars)
#'      cache(mtcars)                      # cache/mtcars.rds
#'      # cache( mtcars, "mycache" )           # mycache/mtcars.rds
#'      # cache( mtcars, "mycache", Sys.Date ) # mycache/mtcars-YYYY-MM-DD.rds
#'
#'      # EXPLICIT USE OF timestamp
#'      # options( timestamp = Sys.Date )
#'      # cache( mtcars, "mycache" )          # mycache/mtcars-YYYY-MM-DD.rds
#'
#'      uncache(mtcars)
#'      # uncache_("mtcars")
#'
#'      cache_use_rds()
#'      cache(mtcars)
#'      if( exists('mtcars') ) rm(mtcars)
#'      uncache(mtcars)
#'   }
#'
#' @md
#' @export

cache <- function(
      object
    , name = deparse(substitute(object))
    , cache = getOption('cache', 'cache' )
    , timestamp = getOption('timestamp')
    , envir = parent.frame()
    , fun = getOption( 'cache.write', cache_write_rds )
) {

  cache_(name, cache, timestamp, envir, fun=fun )

}

#' @rdname cache
#' @import fs
#' @export

cache_ <- function(
    name
  , cache = getOption('cache', 'cache' )
  , timestamp = getOption('timestamp')
  , envir = parent.frame( )
  , fun = cache_write_rds
) {

    object <- get( name, envir )

    object <- structure( object, cache_time = Sys.time() )

    if( is.function(timestamp) ) timestamp <- timestamp()
    if( ! is.null(timestamp) ) timestamp <- paste0("-", timestamp[[1]] )

    if ( ! dir_exists(cache) ) {
      message( "Creating cache ... ", cache)
      dir_create( cache, recursive = TRUE )
    }

    # path <- fs::path( cache, paste0( name, timestamp, ".rds") )
    path_extensionless <- fs::path( cache, paste0( name, timestamp ) )

    # save_rds( object, fileme = path )
    fun( object, name=name, cache=cache )

}


#' @rdname cache
#' @export

cache_all <- function( ... ) {

  warning("Not implemented yet.")

}

