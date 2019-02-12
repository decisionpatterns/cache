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

#' @details
#' `as_backend` retrieves the backend based on `x`. `x` can be the name of the
#' backend, the extension associated with the backend or a file (with a known
#' extension). In every case, a backend object is returned.
#'
#' @return
#' `as_backends` returns a backend object based on `x`:
#'
#'  - character : backends named x
#'  - fs_ext    : backend with x as its path extension
#'  - fs_path   : backend that matches the same extension as the path
#'
#' @rdname backend
#' @export

as_backend <- function(x, ...) UseMethod('as_backend')


#' @rdname backend
#' @export

as_backend.character <- function(x, ... ) {
  backends() %>% Filter( function(backend) backend$name == x, . ) %>% .[[1]]
}


#' @examples
#'   'rds' %>% fs_ext() %>% as_backend() %>% .$name
#'
#' @rdname backend
#' @export

as_backend.fs_ext <- function(x, ... ) {
   backends() %>% Filter( function(backend) backend$ext == x, . ) %>% .[[1]]
}


#' @examples
#'   'cache/iris.rds' %>% fs_path() %>% as_backend() %>% .$name
#'
#' @rdname backend
#' @export

as_backend.fs_path <- function(x, ... ) {
   ext <- x %>% as_fs_ext(...)
   as_backend(ext, ... )
}
