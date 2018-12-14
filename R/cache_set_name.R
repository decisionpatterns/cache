#' cache_name
#'
#' Get or set the default *name* for the cache directory (not the path). The
#' default is 'cache'.
#'
#' @param name string; name for the cache
#'
#' @details
#'
#' `cache_set_name` can be used provide an alternative name other than `cache`.
#' Some useful names are '.cache' (hidden) or '.rcache' (possibly avoiding conflicts).
#'
#' [cache_name()] is an alieas for [cache_get_name()] or `cache_name` return this value.
#'
#' @seealso
#'  * [cache_path()]
#'
#' @export

cache_name <- function() {
  getOption('cache.name','cache')
}

#' @rdname cache_name
#' @export

cache_get_name <- cache_name


#' @rdname cache_name
#' @export

cache_set_name <- function(name) {
  options( cache_name = name )
}



