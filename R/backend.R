#' cache backend
#'
#' An backend definitions
#'
#' @param name string; name of backend.
#' @param reader function for reading from the cache
#' @param writer function for writing to the cache
#' @param ext string extension associated with this file without the period.
#' @param ... other name-value pairs that are stored as part of the definitions
#'
#' @details
#'
#' A backend is the way cache reads and writes from the cache. This simply
#' collects all the information associated with the backend in one list.
#'
#' @return list with subclass `backend`
#'
#' @seealso
#'  - [backends()]
#'  - [cache::cache_register()]
#'
#' @examples
#'
#'   backend( name="rds", reader=function() NULL, writer=function() NULL, ext="rds" )
#'
#' @export

backend <- function(
    name
  , reader
  , writer
  , ext
  , ...
) {

  if( ! is.string(name) ) stop("name must be a string" )
  if( ! is.function(reader) ) stop("reader must be a function" )
  # if( ! is.function(reader) ) stop("writer must be a function")
  if( ! is.string(ext) ) stop("name must be a string" )


  backend <- list(
        name = name
      , extension = ext
      , reader = reader
      , writer = writer
      , ...
    )

  backend <- add_class( backend, "backend" )

  backend
}

#' @rdname backend
#' @export
print.backend <- function(x, ...) {
  cat( 'A (cache) backend named', squote(x$name), 'associate with extension(s): ', squote(x$extension) )
}

#' Various functions for working with cache backends.
#'
#' @param backend string; name for backend
#'
#' @details
#'
#' A backend for a cache contains complete details about storing and
#' retrieving files
#'





#' @details
#' `backend_ext()` gives the extensions associated with a backend.
#'
#' @return
#'   A `ext()` object for the `backend`
#'
#' @seealso
#'  - [cache_backend()]
#'
#' @rdname backend
#' @export

backend_ext <- function( backend=cache_backend() )
  ext( backend_get(backend)$ext )


#' #' Get backend name(s) from extension(s)
#' #'
#' #' @param ext string
#' #'
#' #' @examples
#' #'
#' #'  ext_to_backend("rds")  # 'rds'
#' #'  ext_to_backend("none") # NULL
#' #'
#' #'  ext_to_backend( c('rds','sodium.rds') )
#' #'
#' #' @export
#'
#' ext_to_backend <- function(ext) {
#'
#'   # exts <- backends_exts()
#'   backends() %>% Filter( function(x) x$ext == ext, . ) %>% .[[1]] %>% .$name
#'
#'   # backends <- exts[ exts == ext ] %>% names()
#'   # if( length(backends) == 0 ) return(NULL)
#'   # backends
#'
#' }

#' @export

name_to_reader <- function(name) {
  backend <- name %>% as_cached_file() %>% as_cached_ext() %>% ext_to_backend()
  backend_get(backend)$reader

}

#' @export

path_to_reader <- function(path) {
  path %>% as_cached_path() %>% as_cached_name() %>% name_to_reader()
}
