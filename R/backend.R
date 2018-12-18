#' cache backend
#'
#' Various functions for working with cache backends.
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



# backend <- function() getOption('cache.backend')

# backend_name <- function() getOption('cache.backend')

backend_to_ext <- function(backend)
  cache_ext( backend_get(backend)$ext )

backend_ext <- function( backend=getOption('cache.backend') )
  backend_get(backend)$ext

# backend_ext()

#' Get backend name(s) from extension(s)
#'
#' @param ext string
#'
#' @examples
#'
#'  ext_to_backend("rds")  # rds
#'  ext_to_backend("none") # NULL
#'
#'  ext_to_backend( c('rds','sodium.rds') )
#'
#' @export

ext_to_backend <- function(ext) {

  exts <- backend_exts()
  backends <- exts[ exts == ext ] %>% names()

  if( length(backends) == 0 ) return(NULL)

  backends

}
