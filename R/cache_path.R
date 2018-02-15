#' cache_path
#'
#' Get or set the cache path
#'
#' @param x string; path of the cache directory
#' @details
#'
#' If `x` is `NULL`, returns the `getOption('cache','cache')`. Otherwise, the
#' cache path is set to `x`.
#'
#' While `getOption('cache','cache')` can be used, this provides an interface
#' that can allow the cache path information to change in one place
#'
#' @return string; path to the cache directory
#' @seealso
#'  - [cache()], [uncache()]
#'
#' @md
#' @export

cache_path <- function(x=NULL) {

  if( ! is.null(x) )
    options( cache = x[[1]] )

  getOption('cache', 'cache')

}

