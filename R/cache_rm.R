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
#'
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

cache_rm <- function( ..., .cache=cache_path() ) {

  items <- as.character( substitute( list(...) ))[-1]

  li <- list(...)
  if( length(li)==1 && is.character(li[[1]]) )
    items <- li[[1]]

  re.exts <- backends_exts() %>% as_regex()

  items %>% as_cached_path() %>% fs::file_delete()
  items %>% manifest_rm()

}

# cache_rm_this <- function(x, ...) UseMethod("cache_rm_this")
# cache_rm_this.


#' @details
#' [cache_delete()] is an alias for [cache_rm()].
#'
#' @rdname cache_rm
#' @export

cache_delete <- cache_rm
