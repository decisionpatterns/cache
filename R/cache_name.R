#' cache_name
#'
#' Get/set the default *name* for the cache directory (not the path). The
#' default is `cache`.
#'
#' @param name string; name for the cache (Default: Null)
#'
#'@details
#'
#' If used `name` is not provided or NULL, `cache_name` provides the default
#' cache name.
#'
#' If `name` is provided, the default name is set to `name`.
#'
#' The default cache directory name can be changes by setting
#' `options(cache=name)`.  The default is `cache` but alternative can be useful
#' such as `.cache` (hidden) or `rcache` (possibly avoiding conflicts).
#'
#' @return string name for the cache directory.
#'
#' @seealso
#'  - [cache_path()] which finds the path to the cache directory.
#'
#' @export

cache_name <- function(name=NULL) {

  if( ! is.null(name) ) options( cache.name = name )

  getOption('cache.name','cache')

}
