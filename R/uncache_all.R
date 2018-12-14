#' @rdname cache
#' @export

uncache_all <- function( cache=getOption('cache', 'cache'), envir=parent.frame() ) {

  # stop("`uncache_all()`` is not implemented.")
  # THE PROBLEM HERE IS THAT WE NEED A BETTER WAY TO RESOLVE METHODS FROM

  if( ! dir.exists(cache)) stop( "Cache", cache, "does not exist." )

  files <- dir( cache, full.names=FALSE )
  for( f in files ) {
    if( getOption('verbose') ) message( "Loading ...", f )
    f <-f %>% fs::path_ext_remove() %>% as.characte
    uncache(f)
  }

}
