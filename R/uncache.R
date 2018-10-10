#' @rdname cache
#' @import lazyeval fs
#' @export

uncache <- function(
    name
  , cache=getOption('cache','cache')
  , ...
  , timestamp = getOption('timestamp')
  , envir=parent.frame()
  , overwrite=TRUE
  , fun = getOption( 'cache.read', cache_read_rds )
) {

  name <- as.character( expr_find(name) )

  if( ! fs::dir_exists(cache) ) stop("Cache, ", cache, " does not exist")

  object <- fun(name, cache, ...)
  assign( name, object, envir = envir )  # side-effect

  return( invisible(object) )

}



#' @rdname cache
#' @export

uncache_ <- function(...) {

  warning( "'uncache_' is deprecated. Use 'uncache' instead." )

  uncache(...)

}


#' @rdname cache
#' @export

uncache_all <- function( cache=getOption('cache', 'cache'), envir=parent.frame() ) {

  stop("`uncache_all()`` is not implemented.")
  # THE PROBLEM HERE IS THAT WE NEED A BETTER WAY TO RESOLVE METHODS FROM

  if( ! dir.exists(cache)) stop( "Cache", cache, "does not exist." )

  files <- dir( cache, full.names=FALSE )
  for( f in files ) {
    if( getOption('verbose') ) message( "Loading ...", f )
    f <-f %>% fs::path_ext_remove() %>% as.characte
    uncache(f)
  }

}
