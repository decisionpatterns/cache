#' Create a cached_file
#'
#' Create a name for an object.
#'
#' @param x character
#'
#' @details
#'
#' A cached_file is an `fs_path` object for the object. It is the filename
#' without the path information.
#'
#' @examples
#'  as_cached_file(iris)   # e.g. "iris.rds"
#'  as_cached_file('iris') # e.g. "iris.rds"
#'
#'  cached_file('iris')    # "fs_path"   "character"
#'
#' @return
#' a `fs::fs_path` object of the filename. The extension
#'
# @export


cached_file <- function(x, ext=cache_ext() ) {
  x <- as.character( substitute(x) )  # capture as character.
  as_cached_file(x, ext)
}


as_cached_file <- function(x, ext=cache_ext() ) UseMethod("as_cached_file")

as_cached_file.default <- function(x, ext=cache_ext() ) {
  x <- as.character( substitute(x) )    # capture character
  as_cached_file(x, ext )
}

as_cached_file.character <- function(x, ext=cache_ext() ) {

  if( ! ext %in%  backend_exts() )
    stop( "'", ext, "' is not a registered extension." )

  x <- paste0( x, ".", ext )
  fs::path(x)
}
