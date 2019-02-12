#' Name for cached object
#'
#' User-friendly object name. It doesn't contain either path or ext information
#'
#' @return a `cached_name` object
#'
#' @seealso
#'  - [cached_file()]
#'  - [cached_path()]
#'  - [cached_ext()]
#'
#' @examples
#'
#'   cached_name('iris')
#'
#'   as_cached_name('iris')
#'   as_cached_name(iris)
#'
#'   as_cached_file("iris.rds") %>% as_cached_name()
#'
#' @rdname cached_name
#' @export

cached_name <- function(x) {
  if( ! is.character(x) )
    stop("Only character vectors can a  'cached_name'")
  add_subclass(x, 'cached_name')
}

#' @param ... additional arguments
#' @rdname cached_name
#' @export
#print.cached_name <- function(x,...) print( unclass(x), ...)
print.cached_name <- function(x, ...) print_object(x, ... )



#' @rdname cached_name
#' @export
as_cached_name <- function(x=NULL) UseMethod('as_cached_name')

#' @rdname cached_file
#' @export
as_cached_name.NULL <- function(x) cached_name( character(0))

#' @rdname cached_file
#' @export
as_cached_name.default <- function(x) {
  x <- as.character( substitute(x) )    # capture character
  as_cached_name(x)
}


#' @rdname cached_name
#' @export
as_cached_name.character <- function(x) cached_name(x)


#' @details
#' `as_cached_name.fs_path` handles `cached_file` and `cached_path` objects
#'
#' @examples
#'   cached_file("iris.rds") %>% as_cached_name()
#'   cached_path("iris.2.rds") %>% as_cached_name()
#'
#' @rdname cached_name
#' @export

as_cached_name.fs_path <- function(x) {

  exts <- backends_exts()        # Available backend extensions
  exts <- exts[ exts %>% nchar() %>% order() %>% rev() ]  # Order by longest
  exts.re <- exts %>% fs_ext() %>% as_regex() # Backend exts regular expressions

  ret <- c()
  for( p in x ) {
    for( re in exts.re ) {

      path.file <- fs::path_file(p)  # filename portion of path

      if( str_detect( path.file, re ) ) {
        nm <- stringr::str_replace( path.file, re, '' )   # replace extension
        ret. <- structure( nm, names=path.file )
        break()  # FOUND IT
      }

    }

    if( ! exists('ret.') )
      ret. <- structure( NA_character_, names=path.file )
    ret <- c( ret, ret. )
    rm( ret. )
  }

  ret

  as_cached_name( ret )
}
