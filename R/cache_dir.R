#' cache_dir
#'
#' List contents of the cache directory
#'
#' @param cache string; cache directory
#'
#' @details
#'
#' Similar to `ls` but defaults to viewing the cache directory.
#'
#' @seealso
#' [cache()], [uncache()]
#'
#' @md
#' @export

cache_dir <- function( cache=getOption('cache', 'cache'), ... ) {

   base::dir( path=cache, ... )

}
