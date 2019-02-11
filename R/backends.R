#' Get backends
#'
#' Returns (the list of) backends
#'
#' @details
#' `backends` returns the list of registered backends
#'
#' @return
#' `backends` returns a list of backends cache backends stored in the
#' option `cache.backends`
#'
#' @rdname backends
#' @export

backends <- function() getOption('cache.backends')

#' @details
#' `backend_ls` lists the names of registered backends.
#'
#' @return
#' character vector of names for the backends
#'
#' @rdname backends
#' @export

backends_ls <- function() names( backends() )

#' @rdname backends
#' @export
backend_ls <- function() {
  .Deprecated( 'backends_ls()' )
  backends_ls()
}


#' @details
#' `backends_exts` lists the registered extensions.
#'
#' @return
#' `backends_exts` returns a named character vector `backend_name` => `ext`
#'
#' @rdname backends
#' @export

backends_exts <- function() {
  fs_ext( sapply( backends(), function(x) structure( x$ext, names=x$names ) ) )
}
