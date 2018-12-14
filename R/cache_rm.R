#' cache_rm
#'
#' Remove item(s) from the cache
#'
#' @param ... character; names of cached objects to permanently remove from
#' the cache
#' @param .cache path; cache directory
#'
#' @md
#' @export

cache_rm <- function( ..., .cache=cache_find() ) {

  items <- as.character( substitute( list(...) ))[-1]

  fs::path( .cache, items )

}


#' @rdname cache_rm
#' @export

cache_delete <- cache_rm
