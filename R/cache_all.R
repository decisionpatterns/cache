#' cache_all
#'
#' cache all objects
#'
#' @param ... additional arguments passed to [cache()]
#' @param envir environment from which to find objects to save.
#'
#' @seealso
#'  - [base::save()]
#'
#' @export

cache_all <- function( ..., envir=parent.frame() ) {

  for( nm in ls( envir=envir ) )
    cache_write(nm,...)

}
