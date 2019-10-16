#' parenthesize (Taken from base.tools)
#'
#' encase in parenthseis, brackets, or braces
#'
#' @param x arguments to encase in parentheses
#'
#' @details
#'
#' \code{x} is coerced to character and encased in parens, brackets or braces
#'
#' @references
#'
#' \url{http://english.stackexchange.com/questions/3379/bracket-vs-brace}
#'
#' @return
#'   character
#'
#' @export

parenthesize <- function(x)
  paste( "(", as.character(x), ")", sep="" )

#' @rdname parenthesize
#' @export

bracketize <- function(x)
  paste( "[", as.character(x), "]", sep="" )

#' @rdname parenthesize
#' @export

bracize <- function(x)
  paste( "{", as.character(x), "}", sep="" )
