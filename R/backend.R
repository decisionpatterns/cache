#' backend
#'
#' List the cache backend
#'
#' @export

backend <- function() getOption('cache.backend')

# backend_name <- function() getOption('cache.backend')

backend_to_ext <- function(backend)
  backend_get(backend)$ext

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
