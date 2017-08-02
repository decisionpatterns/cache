#' Cache and uncache an object
#'
#' Caches or uncaches and object in a cache directory
#'
#' @param object object to cache
# @param object_name string; name for the object
#' @param name string; name for the object
#' @param cache character; path to cache directory. The default is
#'        `getOption('cache')` or else simply `cache`
#' @param timestamp string or function (of 0 arguments); timestamp to add to
#'        the filename.
#' @param envir where to uncache the object. Defaults to the caller's environment
#' @param overwrite logical; whether to overwrite if it `name` already exists
#'        on the environment.
#' @param ... additional arguments
#'
#' `cache`/`cache_` and `uncache`/`uncache_` save and restore single objects to
#' the a `cache` directory with `saveRDS`.
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
#' @seealso
#'   `base::saveRDS` \cr
#'
#' @examples
#'   \dontrun{
#'      cache( myfile )                      # cache/myfile.rds
#'      cache( myfile, "mycache" )           # mycache/myfile.rds
#'      cache( myfile, "mycache", Sys.Date ) # mycache/myfile-YYYY-MM-DD.rds
#'
#'      # EXPLICIT USE OF timestamp
#'      options( timestamp = Sys.Date )
#'      cache( myfile, "mycache" )          # mycache/myfile-YYYY-MM-DD.rds
#'
#'      uncache(myfile)
#'      uncache_("myfile")
#'   }
#'
#' @md
#' @export

cache <- function(
      object
    , cache = getOption('cache', 'cache' )
    , timestamp = getOption('timestamp')
    , envir = parent.frame()
) {

  name <- deparse( substitute(object) )

  cache_(name, cache, timestamp, envir )

}

#' @rdname cache
#' @export

cache_ <- function(
    name
  , cache = getOption('cache', 'cache' )
  , timestamp = getOption('timestamp')
  , envir = parent.frame( )
) {

    object <- get( name, envir )

    object <- structure( object, cache_time = Sys.time() )

    if( is.function(timestamp) ) timestamp <- timestamp()
    if( ! is.null(timestamp) ) timestamp <- paste0("-", timestamp[[1]] )

    if ( ! dir.exists(cache) ) {
      message( "Creating cache ... ", cache)
      dir.create( cache, recursive = TRUE )
    }

    saveRDS( object, file = file_path( cache, paste0( name, timestamp, ".rds")) )

}


#' @rdname cache
#' @import lazyeval
#' @export

uncache <- function(
  name, cache=getOption('cache','cache'), timestamp = getOption('timestamp'), envir=parent.frame(), overwrite=TRUE
) {

  name <- as.character( expr_find(name) )

  if( ! dir.exists(cache) ) {
    stop("Cache, ", cache, " does not exist")
  }

  file = file_path(cache, paste0(name, timestamp, ".rds") )

  # assign( name, loadRDS(file), pos=1 )
  file.tools::loadRDS( file, envir=envir )

  return( invisible(TRUE) )
  # warning( "This function is likely to be renamed.")
  # object_name <- lazyeval::expr_find(name) %>% as.character  # e.g. deparse(substitute(name))

  # uncache_(object_name, ... )

}


#' @rdname cache
#' @export

cache_all <- function( ... ) {

  warning("Not implemented yet.")

}




#' @rdname cache
#' @export

uncache_ <- function(...) {

  warning( "'uncache_' is deprecated. Use 'uncache' instead." )

  uncache(...)

}

# uncache_ <- function( name, cache=getOption('cache','cache'), timestamp = getOption('timestamp'), envir=parent.frame() ) {
#
#   if( ! dir.exists(cache) ) {
#     stop("Cache, ", cache, " does not exist")
#   }
#
#   file = file_path(cache, paste0(name, timestamp, ".rds") )
#
#   # assign( name, loadRDS(file), pos=1 )
#   file.tools::loadRDS( file, envir=envir )
#
# }



#' @rdname cache
#' @export

uncache_all <- function( cache=getOption('cache', 'cache'), envir=parent.frame() ) {

 file.tools::loadRDSdir(cache, envir = envir )

}


