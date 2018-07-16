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
#' @export
cache_path <- function(path=NULL) {

  if( ! is.null(path) )
    options( cache = path[[1]] )

  getOption('cache', 'cache')

}
