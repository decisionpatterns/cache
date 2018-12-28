#'
#'
#' Get/set the cache path
#'
#' @param path path or string; location for the cache directory
# @param create logical; create path if it does not exist (Default:`FALSE``)
#' @param verbose whether to announce change of `path` (Default: `FALSE`)
#'
#' @details
#'
#' Without a `path` argument or `path=NULL`, `cache_path()` returns the
#' (relative) path to the cache directory. This is provided by
#' `options(cache.path)`.
#'
#' When `path` is given, the `cache_path` is set.  If `path` does not exist,
#' an error is thrown. The cache should be initialized with `cache_create(...)`
#' first. `NULL` is allowed and does not throw an error.
#'
#'
#' @return Always returns the value of `getOptions('cache.path')`
#'
#' @seealso
#'  - [cache_create()]
#'  - [fs::path_rel()]
#'
#' @export

cache_path <- function(path, verbose=getOption('verbose', FALSE) ) {

  # GET:
  if( missing(path) ) return( getOption('cache.path') )

  # SET:
  # Warn if path does not exist
  if( !is.null(path) && !fs::dir_exists(path) )
    stop( "'", path, "' does not exist; create it with: cache_create(", squote(path), ")" )

  # OLD
  old_path <- getOption('cache.path')

  # SET
  if( is.null(path) )
    options( cache.path = NULL ) else
    options( cache.path = fs::path(path) )

  path.str     <- ifelse( is.null(path), "NULL", path )
  old_path.str <- ifelse( is.null(old_path), "NULL", old_path )

  # MESSAGE
  if(
     path.str != old_path.str &&
     verbose
  ) {
    message(
      "cache path changed from "
      , squote( old_path.str )
      , " to "
      , squote(path.str)
    )
  }

  getOption('cache.path')

}
