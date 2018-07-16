#' cache_set
#'
#' Set the cache set the cache path
#'
#' @param x string; path of the cache directory
#' @details
#'
#' If `x` is `NULL`, returns the `getOption('cache','cache')`. Otherwise, the
#' cache path is set to `x`.
#'
#' While `getOption('cache','cache')` can be used, this provides an interface
#' that can allow the cache path information to change in one place




#' Set or Get Cache Directory
#'
#' Set or gets the cache directory
#'
#' @param path string; path to the cache directory
#'
#' @details
#'
#' `cache_set` sets the cache directory, creating it if it doesn't exist.
#'
#' 'cache_get' returns the cache directory.
#'
#' `cache_path` will get or set the cache path depending on whether `path` is
#' provided.
#'
#' @return string; path to the cache directory. `set_path`` does this invisibly
#' @seealso
#'  - [cache()], [uncache()]
#' @export

cache_set <- function( path ) {

  if( ! dir.exists(path) ) dir.create(path)

  options( cache = path )

  invisible(path)

}


#' @rdname cache_set
#' @export
cache_get <- function() getOption('cache')


#' @rdname cache_set
#' @aliases CACHE
#' @export
cache_path <- function(path=NULL) {

  if( ! is.null(path) )
    options( cache = path[[1]] )

  getOption('cache', 'cache')

}
