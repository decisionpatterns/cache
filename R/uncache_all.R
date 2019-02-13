#' Uncache all objects
#'
#' uncache all objects on the cache
#'
#' @param envir where to uncache the objects (Default: parent.frame()
#' @param overwrite logical; whether to overwrite existing objects
#'
#' @seealso
#'  - [uncache()]
#'  - [cache()]
#'  - [cache_all()]
#'
#' @export

uncache_all <- function(
    envir = parent.frame()
  , overwrite = getOption('uncache.overwrite', TRUE)

) {
  for( obj in cache_ls() )
    assign( obj, cache_read(obj), envir = envir  )
}

