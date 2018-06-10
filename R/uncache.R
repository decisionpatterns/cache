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
  object <- file.tools::loadRDS( file, envir=envir )

  return( invisible(object) )
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
