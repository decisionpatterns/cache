#' Find Root or  NULL
#'
#' Find the root or return NULL -- used when you don't know if you are in
#' a pack
#' @importFrom rprojroot find_root

find_root_safe <- function(...) {
 x <- NULL
 try( x <- find_root(...), silent=TRUE )
 return(x)
}
