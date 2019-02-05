#' filename extension
#'
#' A **general** filename extension object
#'
#' @param x object; values to be converted to character. Character values
#' should omitting the leading `.` (period)
#'
#' @details
#' [ext()] provides a object for handling file/path extensions. This is simply
#' a character vector available to subclass methods. This is a general filename
#' extension that doest not necessarily follow the **fs** package notion of
#' an extension which takes the text after the final period of a filename or
#' path. The `ext` object does not enforce or suggest this and the extension
#' may include one or more `.` (periods).  Thus `tgz` and `tar.gz` are both
#' permissable extensions.
#'
#' The reason for this generality is that it allows (promotes) naming schemes
#' that have names after the process applied to the data. For example, `tar.gz`
#' means that first the data was processed with `tar` and then with `gz`.
#'
#' @seealso
#'  - [fs::path_ext()]
#'
#' @examples
#'   ext( qw(one, two, three) )
#'
#' @export

ext <- function(x=NULL)
  add_class( as.character(x), "ext" )


#' @import crayon
#' @rdname ext
#' @export

print.ext <- function(x, ...) {
  message( 'A ', class(x)[[1]], ' object:')
  x %>%
    unclass() %>%
    crayon::red() %>%
    # squote() %>%
    collapse_comma() %>%
    cat("\n")

}


#' @rdname ext
#' @export
as_ext <- function(x, ...) UseMethod('as_ext')


#' @rdname ext
#' @export
as_ext.default <- function(x, ... ) {
  ext(x)
}


as_ext.cached_path <- function(x, exts=backend_exts() ) {

  exts <- exts[ exts %>% nchar() %>% order() %>% rev() ]  # Sort  by longest ext

  ret <- ext()  # ext values
  for( p in x ) {          # For each path
    for( ext in exts ) {   # Try each ext (in order)

      re <- ext_to_regex(ext)        #
      path.file <- fs::path_file(p)  # filename portion of path

      if( str_detect( path.file, re ) ) {
        # nm <- stringr::str_replace( path.file, re, '' )
        # nm  <- x
        # nm <- path.file
        # ret <- append( ret, cached_ext(ext) )
        ret. <- ext # ret[[ length(ret)+1 ]] <- ext
        # ret. <- ext # structure( ext, names=nm )
        break()  # FOUND EXTENSION -- STOP SEARCHING
      }

    }

    # Didn't match it add NA_character_ for this path
    if( ! exists('ret.') ) ret. <- NA_character_

    # ret <- append( ret, cached_ext(NA_character_))
    ret[[ length(ret)+1 ]] <- ret.

        # NA for missing extensions
    # if( ! exists('ret.') )
    #  ret. <- structure( rep(NA_character_, length(x)), names=path.file )

    # if( ! exists('ret') )
    #  ret <- ret. else ret <- c( ret, ret. )

    rm( ret. )

  }

  ret
}
