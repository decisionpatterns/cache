#' cache_set_name, cache_get_name
#'
#' Get and set the default name for the cache directory (not the path)
#'
#' @param name string; name for the cache
#'
#' @details
#'
#' `cache_set_name` can be used provide an alternative name other than `cache`.
#' Some examples are '.cache' (hidden) or '.rcache' (possibly avoiding conflicts).
#'
#' `cache_get_name` or `cache_name` return this value.
#'
#' @seealso
#'  * [cache_set()], [cache_get()], [cache_path()]
#'
#' @export

cache_set_name <- function(name) options( cache_name = name )


#' @rdname cache_set_name
#' @export

cache_get_name <- function() getOption('cache_name', 'cache')

#' @rdname cache_set_name
#' @export

cache_name <- cache_get_name
