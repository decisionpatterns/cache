#' cache_rm
#'
#' Remove item(s) from the cache
#'
#' @param ... single character vector of object names or comma separated list of
#'            unquoted names.
#' @param .cache path; cache directory
#'
#' @details
#'
#' [cache_rm()] accepts either a character vector -or- a comma-separated list of
#' unquoted names.
#'
#' @examples
#'
#' \dontrun{
#'   cache(iris)
#'   cache_rm(iris)
#'   cache(iris)
#'   cache_rm('iris')
#'
#'   cache(iris);cache(mtcars)
#'   cache_ls()
#'   cache_rm(iris,mtcars)
#'   cache_ls()
#'
#'
#'   cache(iris);cache(mtcars)
#'   cache_rm( c('iris','mtcars') )
#'   cache_ls()
#' }
#'
#' @md
#' @export

cache_rm <- function( ..., .cache=cache_find() ) {

  items <- as.character( substitute( list(...) ))[-1]

  li <- list(...)
  if( length(li)==1 && is.character(li[[1]]) )
    items <- li[[1]]

  for( item in items ) {
    # Find cached item by name
     path <- name_to_path(item)
     fs::file_delete(path)
  }

}

#' @details
#' [cache_delete()] is an alias for [cache_rm()].
#'
#' @rdname cache_rm
#' @export

cache_delete <- cache_rm
