#' Register cache backend
#'
#' Register a backend for reading and writing to the cache.
#'
#' @param name string; name for the backend.
#' @param read function for reading from the cache, defaults to
#'   function `cache_read_[name]`
#' @param write function; function for writing to the cache,
#' @param ext string; the extension used for the file type, usually everything
#' **after** the final period. Defaults to `name`.
#'
#' @details
#' `cache_backend_register()` registers a extension with functions for reading and
#' writing that file type. The `ext` argument should not include the period.
#'
#' It is mostly for writing extensions writing different types of files.
#'
#' @return
#'
#' The value from [base::options()] is returned
#'
#' @examples
#'
#' \dontrun{
#'   cache_add_ext( 'csv', readr::read_csv, readr::write_csv )
#' }
#'
#' @export

cache_backend_register <- function(
    name
  , reader = get( paste0('cache_read_' , name ) )
  , writer = get( paste0('cache_write_', name ) )
  , ext = name
) {

  backends <- getOption( 'cache.backends', list() )
  backends[[name]] <- list(
        name = name
      , extension = ext
      , reader = reader
      , writer = writer
    )

  options( `cache.backends` = backends )

}


#' @rdname cache_backend_register
#' @export

cache_add_extension <- function(...) {
  .Deprecated( "cache_backend_register", old="cache_add_extension" )
   cache_backend_register(...)
}


#' @rdname cache_backend_register
#' @export

cache_add_ext <- function(...) {
  .Deprecated( "cache_backend_register", old="cache_add_ext" )
  cache_backend_register(...)
}
