#' Cache and uncache an object
#'
#' Caches or uncaches and object in a cache directory
#'
#' @param object object to cache
#' @param name string; name for the object defaults to the
#'   `default(substitute(object))`
#' @param cache string; path to cache directory. The default is
#'        `cache_path()`.
# @param timestamp string or function (of 0 arguments); timestamp to add to
#        the filename.
#' @param ... additional arguments
#' @param envir environment .. where object to cache or to where object should
#'        be uncached. Defaults to the `parent.frame()`
#' @param overwrite logical; whether to overwrite if it `name` already exists
#'        on the environment.
#' @param backend string; (name of) the backend used.
# @param writer function for writing to the cache. Defaults to `cache_writer()`
# @param fun functiontion for writing or reading the objects. Defaults to
# [cache_write_rds()]
#'
#' `cache`/`cache_write` and `uncache`/`cache_read`` save and restore single
#' objects to the `cache` directory. `cache(obj)` and `uncache(obj)` are NSE
#' versions that accept an unquoted name. These are mostly for interactive
#' use.
#'
#' `cache_write()` and `cache_read()` are SE versions more suitable for
#' programatic.
#'
#' `cache` attempts to ensure unique names of the saved object; saving an item
#' in multiple formats is not permitted.
#'
#' dispatching to [cache_writer()] which selects the writer for the current
#' backend.
#'
#' The `cache` defaults to the global option [cache_path()] otherwise
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
#'   - [cache_all()] for saving all objects to the cache.
#'   - [base::saveRDS()]
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
    , cache = cache_path() # getOption('cache', 'cache' )
    , ...
    # , timestamp = getOption('timestamp')
    , overwrite = getOption('cache.overwrite', TRUE )
    , envir = parent.frame()
    , backend = getOption("cache.backend")
) {

  if( is.character(object) ) {

  }

  # x. <- deparse(substitute(object))
  # if( is.string(object) )

  #cache_write(name, cache, timestamp, envir, fun=fun )
  cache_write(
    # object,
      name=name, cache=cache
    , ...
    , overwrite=overwrite
    , envir=envir
    , backend=backend
  )

}


#' @details
#'  `cache_write` is like `cache` but takes a name of an object and an
#'  environment. It is mainly useful for programatic writing to the cache.
#'  `cache_write` will not work unless a cache direcort has been defined. See
#'  [cache_path()].
#'
#' @seelalso
#'  - [cache_path()]
#'
#' @rdname cache
#' @import fs
#' @export

cache_write <- function(
  #  object,
    name
  , cache = cache_path()
  , ...
  # , timestamp = getOption('timestamp')
  , overwrite = getOption('cache.overwrite', TRUE )
  , envir = parent.frame()
  , backend = cache_backend() # getOption('cache.backend')
  # , writer = cache_writer() # getOption( 'cache.write', cache_write_rds )
) {

  writer <- backend_get(backend)$writer
  ext <- backend_get(backend)$ext

  object <- get( name, envir )
  # object <- structure( object, cache_time = Sys.time() )

  # if( is.function(timestamp) ) timestamp <- timestamp()
  # if( ! is.null(timestamp) ) timestamp <- paste0("-", timestamp[[1]] )

  if ( ! dir_exists(cache) )
    stop("Directory, "
         , cache %>% squote
         , " doesn't exist directory doesn't exist. Try creating it with:"
         , "\n  cache_create(", cache, ")"
    )

  # path <- fs::path( cache, paste0( name, timestamp, ".rds") )
  # path_extensionless <- fs::path( cache, paste0( name, timestamp ) )

  # CHECK CONFLICTS: so tat th
  if( has_conflict(name, ext) ) stop( conflict_msg(name) )

  path <- name %>% paste0(".", ext) %>% fs::path(cache, .)

  if( !overwrite && fs::file_exists(path) )
    stop( call.=FALSE
          , "cache_write()"
          , "\n  File ", path %>% squote, " exists and overwrite==FALSE."
    )

  ret <- writer( object, path, ... )   # SIDE-AFFECT

  invisible(object)             # PIPELINE ENABLED: ALWAYS RETURN OBJECT

}
