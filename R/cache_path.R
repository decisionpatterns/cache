#' cache_path
#'
#' Get/set the cache path
#'
#' @details
#'
#' Without a `path` argument or `path=NULL`, `cache_path()` returns the
#' (relative) path to the cache directory. This is provided by
#' `options(cache.path)` or [cache_find()]
#'
#' With a `path` argument specified, `cache_path` set the path for the cache
#' directory.
#'
#' @return [fs::path_rel()] object of the *relative* path to the cache directory.
#' Use [fs::path_abs()] to get the absolute path.
#'
#' @seealso
#'  - [cache_name()]
#'  - [cache_find()]
#'
#' @export

cache_path <- function(path=NULL) {

  if( ! is.null(path) )
    options( cache.path = path[[1]] )

  path <- getOption( 'cache.path', cache_find() )

  if( ! is.null(path) ) path <- fs::path_rel(path)

  path
}
