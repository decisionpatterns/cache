#' Create a cached_file
#'
#' Create a name for an object.
#'
#' @param x object
#' @param ext ext or string used in the cache
#' @param ... additional arguments
#'
#' @details
#'
#' A `cached_file` is a subclass of `fs_path` object without the directory.
#' It is the filename without the path information.
#'
#' @return
#' a `cached_file` (subclass of `fs::fs_path`) object of the filename. The extension
#'
#' @examples
#'  cached_file('iris.rds') # e.g. "iris.rds"
#'  as_cached_file('iris.rds')  # Warn: Don't include extension
#'  as_cached_file('iris', 'rds' )
#'  as_cached_file(iris)
#'
#' @import stringr.tools
# @export

cached_file <- function(x)  {
  x <- as.character(x)
  re <- backends_exts() %>% as_regex()
  wh <- x %>% str_grepv(re)
  if( length(wh)>0 )
    warning( "Files without registered extensions: ", x %>% squote %>% collapse_comma() )
  x <- fs::path_file(x)
  add_subclass(x,'cached_file')
}

#' @rdname cached_file
#' @export
print.cached_file <- function(x,...) NextMethod()

  # print( unclass(x, ...))
# cached_file <- function(x, ext=cache_ext() ) {
#   x <- as.character( substitute(x) )  # capture as character.
#   as_cached_file(x, ext)
# }

#' @rdname cached_file
#' @export

as_cached_file <- function(x, ext=cache_ext() ) UseMethod("as_cached_file")


#' @rdname cached_file
#' @export
as_cached_file.default <- function(x, ext=cache_ext() ) {
  x <- as.character( substitute(x) )    # capture character
  as_cached_file(x, ext)
}


#' @rdname cached_file
#' @export
as_cached_file.character <- function(x, ext=cache_ext() ) {

  # Try and be smart about what is being provided.
  if( is.null(ext) ) return( cached_file(x) )
  if( str_detect( x, as_regex(ext) ) )  { # Already has extension
    # warning(
    #   squote(x), " already has the extension ", squote(ext), "\n"
    # )
    return( cached_file(x) )
  }

  x <- paste0( x, '.', ext )
 cached_file(x)

}


#' @rdname cached_file
#' @export
as_cached_file.fs_path <- function(x, ext=NULL) {
  x <- fs::path_file(x)
  cached_file(x)
}

#' @examples
#'   cached_name('iris') %>% as_cached_file()
#' @rdname cached_file
#' @export
as_cached_file.cached_name <- function(x, ext=cache_ext() ) {
   as_cached_file.character(x, ext=ext)
}
