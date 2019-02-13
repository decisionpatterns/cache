#' Get Caching Functions
#'
#' Get the reader or writer function for a path
#'
# @param path string; path to file.
#
#' @details
#'
#' `cache_reader()` and `cache_writer()` return the function for reading
#' and writing to/from the cache.
#'
#' @seealso
#'  - [cache_backend()]
#'
#' @examples
#'   cache_reader()
#'
#' @importFrom stringr str_detect
#' @rdname cache_reader
#' @export

cache_reader <- function(x=NULL) UseMethod('cache_reader')

#' @rdname cache_reader
#' @export
cache_reader.NULL <- function(x)
  backend_get( cache_backend() )$reader


#' @examples
#'   cache_reader( fs_ext('rds') )
#'
#' @rdname cache_reader
#' @export
cache_reader.fs_ext <- function(x) {
  x %>% as_backend() %>% .$reader
}

#' @examples
#'   path( "cache/iris.rds") %>% cache_reader()
#'
#' @rdname cache_reader
#' @export
cache_reader.fs_path <- function(x) {
  x %>% as_backend() %>% .$reader
}


#' @examples
#'   'iris' %>% cached_name() %>% cache_reader()
#'
#' @rdname cache_reader
#' @export
cache_reader.cached_name <- function(x)
  x %>% as_cached_path() %>% cache_reader()






#' @rdname cache_reader
#' @export

cache_writer <- function()
  backend_get( cache_backend() )$writer
