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

# collapse.regex?
as_regex.fs_ext <- function(x, ...) {
  re <- paste0( "\\.(", collapse(x, "|"), ")$" )
  regex(re, ...)
}

#' @rdname as_regex
#' @export
print.regex <- function(x, ...) print_object(x, ...)
