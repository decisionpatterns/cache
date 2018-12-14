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


cached_file <- function(x, ext=backend_ext() ) {
  x <- as.character( substitute(x) )  # capture as character.
  as_cached_file(x, ext)
}

# print.cached_file <- function(x)
#   print( unclass(x) )


as_cached_file <- function(x, ext=backend_ext() ) UseMethod("as_cached_file")

as_cached_file.default <- function(x, ext=backend_ext() ) {
  x <- as.character( substitute(x) )    # capture character
  as_cached_file(x, ext )
}

as_cached_file.character <- function(x, ext=backend_ext() ) {

  if( ! ext %in%  backend_exts() )
    stop( "'", ext, "' is not a registered extension." )

  x <- paste0( x, ".", ext )
  fs::path(x)
}




# possible_files <- function(name) {
#   paste0( name, ".", backend_exts() ) %>%
#     fs::path()
# }


# cached_name <- function(x) UseMethod('cached_name')
#
# cached_name.character <- function(x) {
#   x %>% add_subclass("cached_name")
# }
#
# #' This version is not usable anywhere other than the environment in which
# #' x is defined; and is not usable
#
# cached_name.default <- function(x) {
#   # lazyeval::expr_find(x) %>%
#   substitute(x) %>%
#     as.character() %>%
#     add_subclass("cached_name")
# }
#
# f <- function(x) {
#   cached_name(x)
# }

# cached_name(iris)
# f(iris)
