#' cached_ext - cached objects file extension
#'
#' A character object representing the extension of a cached object.
#'
#' @param x object to make a cached_ext object from usually a string or character
#'
#' @details
#'
#' The **cached_extension** of an object is a file extension if it is one of the
#' registered file extensions.  For a generic extension object, see [ext()].
#'
#' The extension of a cached object is not limited to everything following the
#' final period in an cached object. (This is usually the case.)
#'
#' A `cached_ext` is character vector representing one or more extensions of
#' cached objects
#'
#' @examples
#'   # cached_ext()
#'   cached_ext("rds")
#'   cached_ext(1)
#'
#' @export

cached_ext <- function( x=character() ) {

  if( ! is.character(x) ) x <- as.character(x)
  if( ! is.character(x) ) stop("Only character vectors can a  'cached_ext'")

  x <- fs_ext(x)
  x <- add_subclass(x, 'cached_ext')
  # class(x) <- c('cached_ext', "character")
  x

}



#' @param ... additional arguments
#' @rdname cached_ext
#' @export
print.cached_ext <- function(x,...) {
  message( 'A ', red( class(x)[[1]] ), ' object:')
  print( unclass(x), ...)
}



#' @param exts character; vector of allowed extensions.
#'
#' @details
#' `as_cached_ext` tries to converts unknown types of `x` to `cached_path`
#' before coercing to a `cached_ext`.
#'
#' @examples
#'   as_cached_ext('iris.rds')
#'   as_cached_ext('cache/iris.rds')
#'
#'   as_cached_ext( cached_file('iris.rds') )
#'   as_cached_ext( cached_path('cache/iris.rds') )
#'
#' @rdname cached_ext
#' @export
as_cached_ext <- function(x, exts ) UseMethod('as_cached_ext')


#' @rdname cached_file
#' @export
as_cached_ext.default <- function(x, exts=NULL ) {
  x <- as.character( substitute(x) )    # capture character
  # x <- as_cached_path(x)
  as_cached_ext(x)
}


#' @rdname cached_ext
#' @export
as_cached_ext.character <- function(x, exts=NULL ) {
  x <- as_cached_path(x)
  as_cached_ext(x)
}

#' @details
#'
#' `as_cached_ext` returns the **registered** backend extensions for `x` for
#' `cached_path` and `cached_file` arguments.
#'
#' @examples
#'   path <- cached_path( c("cache/iris.rds", "cached/mtcars.fst") )
#'   as_cached_ext(path)
#'
#' @rdname cached_ext
#' @export

as_cached_ext.cached_path <- function(x, exts=backends_exts() ) {

  exts <- exts[ exts %>% nchar() %>% order() %>% rev() ]  # Sort  by longest ext

  ret <- cached_ext()
  for( p in x ) {         # For each path
    for( ext in exts ) {   # Try each ext (in order)

      re <- ext %>% fs_ext() %>% as_regex()
      path.file <- fs::path_file(p)  # filename portion of path: as_cached_file(?)

      if( str_detect( path.file, re ) ) {
        # ret. <- append( ret, cached_ext(ext) )
        p.ext <- cached_ext(ext)
        break()  # FOUND EXTENSION -- STOP SEARCHING
      }

    }

    # NA for missing extensions
    if( ! exists('p.ext') ) p.ext <- NA_character_

    ret <- append(ret, p.ext)
  }

  cached_ext(ret)
}



#' @examples
#'   files <- cached_path( c("iris.rds", "mtcars.fst") )
#'   as_cached_ext(files)
#'
#' @rdname cached_ext
#' @export

as_cached_ext.cached_file <- as_cached_ext.cached_path # same logic
