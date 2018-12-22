#' Convert to a regular expressions
#'
#' Converts an object to a regular expression for matching
#'
#' @param x an object to convert to a regular expression
#'
#' @details
#' [as.regex()] converts `pattern`
#'
#' @examples
#'   as.regex("pattern")
#'   as.regex( ext('rds') )
#'
#' @importFrom stringr regex
#' @export
as.regex <- function(x, ...) UseMethod('as.regex')

#' @rdname as.regex
#' @export
as.regex.default <- function(x, ... ) regex( pattern=x, ...)

#' @rdname as.regex
#' @export
#'

# PRODUCE MULTIPLE REGEXS
# as.regex.ext <- function(x, ...) {
#
#   collapse(x,"|")
#   pattern <- paste0( "\\.", x, "$" )
#   stringr::regex(pattern, ...)
# }

# collapse.regex?
as.regex.ext <- function(x, ...) {

  re <- paste0( "\\.(", collapse(x, "|"), ")$" )

  regex(re, ...)
}


#' Convert ext to regex
#'
#' Converts an ext to regex; an extension to [stringr::regex()]
#'
#' @param ext string
#'
#' @details
#'
#' Creates a regular expression out of an extension. This will match the end
#' of a file. It has to be a regex rather than fixed in order to match to the
#' end of the filename.
#'
#' @seealso
#'  - [stringr::regex()]
#'
#' @examples
#'
#' ext_to_regex("rds")     # "\\.rds$"
#'
# @export

ext_to_regex <- function(ext) {
  regex <- paste0( "\\.", ext, "$" )
  # regex <-str_replace( regex, ".", "\\.")
  regex
}
