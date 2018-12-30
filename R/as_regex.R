#' Convert to a regular expressions
#'
#' Converts an object to a regular expression for matching
#'
#' @param x an object to convert to a regular expression
#'
#' @details
#' [as_regex()] converts `pattern`
#'
#' @examples
#'   as_regex("pattern")
#'   as_regex( ext('rds') )
#'
#' @importFrom stringr regex
#' @export

as_regex <- function(x, ...) UseMethod('as_regex')

#' @rdname as_regex
#' @export
as_regex.default <- function(x, ... ) regex( pattern=x, ...)

#' @rdname as_regex
#' @export
#'

# PRODUCE MULTIPLE REGEXS
# as_regex.ext <- function(x, ...) {
#
#   collapse(x,"|")
#   pattern <- paste0( "\\.", x, "$" )
#   stringr::regex(pattern, ...)
# }

#'

# collapse.regex?
as_regex.ext <- function(x, ...) {
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
#' ext_to_regex( c("rds", "fst") )
# @export

ext_to_regex <- function(ext) {
  regex <- paste0( "\\.", ext, "$" )
  # regex <-str_replace( regex, ".", "\\.")
  regex
}
