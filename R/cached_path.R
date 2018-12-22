#' Cached object's path
#'
#' The path for a cached object
#'
#' @param x
#' @param cache string; location of the cache directory. (Default: [cache_path()])
#' @param ext string; extension for the file. (Default: [cache_ext()] )
#' @param ... additional arguments
#'
#' @details
#'
#' A `cached_path` is a [fs::path()] object that points to an object in the
#' cache, It is not the cache directory itself.  Use [cache_path()] for getting
#' and setting the location of the cache directory.
#'
#' @seealso
#'  - [cached_file()]
#'  - [cached_name()]
#'  - [cached_ext()]
#'  - [cache_path()]
#'  - [fs::path()]
#'
#' @examples
#'   cached_path("cache/iris.rds")
#'   cached_path( c("cache/iris.rds", "mtcars.rds") )
#'
#' @export

cached_path <- function(x) {
  x <- as.character(x)
  re <- backend_exts() %>% as.regex()
  wh <- x %>% str_grepv(re)
  if( length(wh)>0 )
    warning( "Files without registered extensions: ", x %>% squote %>% collapse_comma() )
  add_subclass(x,'cached_path')
}

#' @rdname cached_path
#' @export
print.cached_path <- function(x, ...) print( unclass(x), ... )


#' @rdname cached_path
#' @export
as_cached_path <- function(x, cache=cache_path(), ext=cache_ext()) UseMethod('as_cached_path')

#' @examples
#'   as_cached_path(iris)
#' @rdname cached_path
#' @export
as_cached_path.default <- function(x, cache=cache_path(), ext=NULL ) {
  x <- as.character( substitute(x) )    # capture character
  x <- paste0( cache, "/", x, ".", ext )
  as_cached_path(x)
}


#' @rdname cached_path
#' @export
as_cached_path.character <- function(x, cache=cache_path(), ext=cache_ext() ) {
  file <- as_cached_file(x, ext=ext)
  as_cached_path( file, cache=cache )
}

#' @examples
#'   cached_file('iris.rds') %>% as_cached_path()
#'
#' @rdname cached_path
#' @export
as_cached_path.cached_file <- function( x, cache=cache_path()) {
  x <- fs::path( cache, x )
  add_subclass(x, 'cached_path')
}


#' @examples
#'   cached_name('iris') %>% as_cached_path()
#'
#' @rdname cached_path
#' @export
as_cached_path.cached_name <- function( x, cache=cache_path(), ext=cache_ext() ) {
  x <- as_cached_file(x, ext=ext )
  as_cached_path(x, cache=cache)
}
