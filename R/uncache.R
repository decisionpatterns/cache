#' @rdname cache
#' @import lazyeval fs file.tools
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

  # file = fs::path(cache, paste0(name, timestamp, ".rds") )

  # assign( name, loadRDS(file), pos=1 )
  # object <- file.tools::loadRDS( file, envir=envir )
  # object <- read_rds(file)

  object <- fun(name, cache, ...)
  assign( name, object, envir = envir )  # side-effect

  return( invisible(object) )

}



#' @rdname cache
#' @import file.tools
#' @export

uncache_ <- function(...) {

  warning( "'uncache_' is deprecated. Use 'uncache' instead." )

  uncache(...)

}


#' @rdname cache
#' @export

uncache_all <- function( cache=getOption('cache', 'cache'), envir=parent.frame() ) {

 file.tools::loadRDSdir(cache, envir = envir )

}
