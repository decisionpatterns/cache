#' cache_reader, cache_writer
#'
#' Get the read or write function for a path
#'
# @param path string; path to file.
#
#' @details
#'
#' `cache_reader{}` and `cache_writer()` return the function for reading
#' and writing to/from the cache.
#'
#' @seealso
#'  - [cache_backend()]
#'
#' @importFrom stringr str_detect
#' @rdname cache_reader
#' @export


cache_reader <- function()
  backend_get( cache_backend() )$reader


#' @rdname cache_reader
#' @export

cache_writer <- function()
  backend_get( cache_backend() )$writer
