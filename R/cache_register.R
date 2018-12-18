#' Register cache backend
#'
#' Register a backend for reading and writing to the cache.
#'
#' @param name string; name for the backend.
#' @param reader function for reading from the cache, defaults to
#'   function `cache_read_[name]`
#' @param writer function; function for writing to the cache,
#' @param ext string; the extension used for the file type, usually everything
#' **after** the final period. Defaults to `name`.
#' @param ... additional name/value pairs to be stored in the backend.
#'
#' @details
#'
#' `cache_register()` defines a backend for storing and retrieving data using
#' cache.  Ultimately, it associated an filename extension with functions for
#' reading and writing cache files with that extension.
#'
#' Unless you are writing a new backend, you will not need to use this function.
#'
#' @return
#'
#' The value from [base::options()] is returned
#'
#' @examples
#'
#'   \dontrun{
#'     cache_register( 'csv', readr::read_csv, readr::write_csv )
#'   }
#'
#' @export

cache_register <- function(
    name
  , reader = get( paste0('cache_read_' , name ) )
  , writer = get( paste0('cache_write_', name ) )
  , ext = name
  , ...
) {

  backends <- getOption( 'cache.backends', list() )
  backends[[name]] <- list(
        name = name
      , extension = ext
      , reader = reader
      , writer = writer
      , ...
    )

  options( `cache.backends` = backends )

}


#' @details
#' `cache_backend_register` is an alias for `cache_register`.
#'
#' @rdname cache_register
#' @export

cache_backend_register <- cache_register
