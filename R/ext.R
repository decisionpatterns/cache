#' filename extension
#'
#' A **general** filename extensions
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

ext <- function(x)
  add_class( as.character(x), "ext" )


#' @rdname ext
#' @export
as.ext <- function(x) ext(x)


#' @import crayon
#' @rdname ext
#' @export
print.ext <- function(x, ...) {
  cat( "filename extensions: " )
  x %>%
    unclass() %>%
    crayon::red() %>%
    # squote() %>%
    collapse_comma() %>%
    cat()
}
