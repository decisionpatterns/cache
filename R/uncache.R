
#' @param reader function for reading from the cache. Defaults to `cache_reader()`
#'
#' @details
#'
#' `uncache` restores an object from disk. It restores based on the name. It
#' looks in the cache
#'
#' @rdname cache
#' @import lazyeval fs
#' @export

uncache <- function(
    name
  , ...
  , envir = parent.frame()
  , overwrite = getOption('uncache.overwrite', TRUE)
  # , reader
  , backend = cache_backend() %>% as_backend()  # Default backend
) {

  # GET STRING name
  name <- as.character(substitute(name))

  # GET reader FROM the extension
  # if( missing(reader) )
  reader <- name %>% as_cached_ext() %>% cache_reader()

  object <- cache_read(name, ..., backend=backend )

  # OVERWRITE! CHECK EXISTENCE
  if( ! overwrite &&  exists(name,envir=envir) ) {
    stop("Object already exists in environment. To overwrite set overwrite=TRUE.")
  }

  assign( name, object, envir = envir )  # side-effect

  return( invisible(object) )

}


#' @details
#'
#'  `cache_read()` is a functional, no side-affect version of `uncache`. It
#'  reads and returns the object. Given a name, [cache_read()] will:
#'
#'  - read the object with the default backend/extension warning if there are
#'    any alternate files.
#'  - read alternate (non-default) files with backends/extensions
#'  - alert and matching but unsupported files.
#'
#' @rdname cache
#' @export

cache_read <- function(
    name                            # string
  , cache = cache_path()
  , ...
  # , reader  # defined by backend
  , backend  # Use non-default backend
  # , timestamp = getOption('timestamp')
) {

  # GET STRING FOR name
  name. <- as.character( expr_find(name) )
  if( ! is.character(name) ) name <- name.

  # TEST if cache exists
  # - this is unnecessary as the file is tested below
  if( is.null(cache) || ! fs::dir_exists(cache) )
    stop( "cache does not exist: '", cache, "'" )

  # FIND path FROM NAME
  path <- as_cached_path(name) #
  # TEST if file exists
  if( ! fs::file_exists(path) ) stop( path, " does not exist")

  # Find reader ..
  reader <- path %>% as_cached_ext() %>% cache_reader()
  reader(path, ...)

}


#' @rdname cache
#' @export

uncache_ <- function(...) {
  warning( "'uncache_' is deprecated. Use 'uncache' instead." )
  uncache(...)
}
