#' squote ((Taken from base.tools)
#'
#' single or double quote text without using Fancy Quotes
#'
#' @param x character; values to enquote
#'
#'  These are the same as `base::sQuote` and
#'  except fancy quotes are not used.
#'
#'  Fancy quotes are temporarily disabled for this function.
#'
#' @seealso
#'    \code{\link[base]{sQuote}} \cr
#'
#' @md
#' @export

squote <- function(x) {
  opt = getOption('useFancyQuotes')
  options(useFancyQuotes = FALSE)
  ret <- base::sQuote(x)
  options(useFancyQuotes = opt)
  return(ret)
}

