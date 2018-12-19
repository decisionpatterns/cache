#' Find Root or  NULL
#'
#' Find the root or return `NULL`` -- used when you don't know whether a root
#' can be found.
#'
#' @examples
#'
#' \dontrun{
#'   find_root( has_dir("xdx") )      # ERROR!
#' }
#'   find_root_safe( has_dir("xdx") ) # NULL
#'
#' @importFrom rprojroot find_root

find_root_safe <- function( criterion, path = ".") {
 x <- NULL
 try( x <- find_root(criterion, path), silent=TRUE )
 if( length(x) == 0 ) x <- NULL
 return(x)
}
