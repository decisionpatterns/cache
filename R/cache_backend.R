#' Get/Set the default cache backend
#'
#' @param backend string; name for the backend.  Note this is not
#' the file extension but the name of a registered backend.
#'
#' @details
#'
#' `cache_backend()` gets or sets the default method(s) for reading and writing
#' from/to the cache. Without an argument, it returns the current default
#' backend. With a string `backend` argument, it sets the default methods to
#' those associated with that backend
#'
#' `cache_backend()` throws an error if no backend is registered for the
#' `backend` argument. Register that backend with [cache_register()] first.
#'
#' @seealso
#'  - [cache_register()]
#'  - [backend_ls()]
#'
#' @export

cache_backend <- function(backend=NULL) {

  if( is.null(backend) )
    return( getOption('cache.backend') )

  #   stop( "You must supply the name of a backend:",
  #         paste( backend_ls() %>% squote(), collapse=", " )
  #   )

  backend <- as.character( substitute(backend) )

  # Load package cache.backend

  if( backend %!in% backend_ls() ) {
      stop(
        "\n"
        , "'", backend, "' is not an available backend."
        , "\n"
        , "Available backends: "
        , paste( squote( backend_ls() ), collapse=", ")
        , "\n"
        , "Use the available `register` method ("
        , paste0( 'cache_register_', backend, '?' )
        , ') to add additional backends.'
      )
  }

  options( cache.backend = backend )
  backend
}

#' @details
#' `cache_default()` is an alias for `cache_backend()`
#'
#' @rdname cache_backend
#' @export

cache_default <- cache_backend
