#' cache_reader, cache_writer
#'
#' Get the read or write function for a path
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
  backend_get(x)$reader
}

#' @examples
#'   cache_reader( path( "cache/iris.rds") )
#'
#' @rdname cache_reader
#' @export
cache_reader.fs_path <- function(x) {
  backend_get(x)$reader
}


#' @rdname cache_reader
#' @export

cache_writer <- function()
  backend_get( cache_backend() )$writer
