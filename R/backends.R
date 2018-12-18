#' Backends
#'
#' Functions to working with cache backends
#'
#' @param backend string; name for backend
#'
#' @details
#'
#' A backend for a cache contains complete details about storing and
#' retrieving files
#'
#' @seealso
#' [cache::cache_register()]


#' @details
#' `backends` returns the list of registered backends
#'
#' @return
#' `backends` returns a list of backends cache backends stored in the
#' option `cache.backends`
#'
#' @rdname backends
# @export

backends <- function() getOption('cache.backends')


#' @details
#' `backend_get` retrieves the definition for the cache backend. The definition
#' is a list that was created by [cache_register()].
#'
#' @return
#' `backend_get` returns a list for the backend.
#'
#' @rdname backends
#' @export

backend_get <- function( backend ) {
  getOption('cache.backends')[[ backend ]]
}



#' @details
#' `backend_ls` lists the names of registered backends.
#'
#' @return
#' character vector of names for the backends
#'
#' @rdname backends
#' @export

backend_ls <- function() backends() %>% names()



#' @details
#' `backend_exts` lists the registered extensions.
#'
#' @return
#' `backend_exts` returns a named character vector `backend_name` => `ext`
#'
#' @rdname backends
#' @export

backend_exts <- function()
  sapply( backends(), function(x) structure( x$ext, names=x$names ) )
