#' Set the default backend for cacheing
#'
#'
#' @param backend string; name for the backend.  Note this is not
#' the file extension but the name used for cacheing.
#'
#' @details
#'
#' `backend_set` sets the default method for reading and writing from the
#' cache. It throws an error if no backend is registered for the methods.
#'
#' @seealso
#'  - [backend_register()]
#'  - [backend_ls()]
#'
#' @export


backend_set <- function(backend) {

  if( missing(backend) )
    stop( "You must supply the name of a backend:",
          paste( backend_ls() %>% squote(), collapse=", " )
    )

  backend <- as.character( substitute(backend) )

  # Load package cache.backend

  if( backend %!in% backend_ls() ) {
      stop(
        "\n"
        , "'", backend, "' is not an available backend."
        , "\n"
        , "Available backends: "
        , paste( backend_ls() %>% squote(), collapse=", ")
        , "\n"
        , "Use the available `register` method ("
        , paste0( 'cache_register_', backend, '?' )
        , ') to add additional backends.'
      )
  }

  options( cache.backend = backend )

}
