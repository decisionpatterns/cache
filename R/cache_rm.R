#' cache_rm
#'
#' Remove item(s) from the cache
#'
#' @param ... objects to be removed as names (unqoted) or character strings
#'            (quoted).
#' @param list character vector naming objects to be removed.
# @param .cache path; cache directory
#'
#' @details
#'
#' [cache_rm()] removes objects from the cache.  Objects can be expressed as
#' character strings, or in the argument `list` or through a combination of
#' both.
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

cache_rm <- function ( ..., list = character() ) {

  dots <- match.call(expand.dots = FALSE)$...

  if( length(dots)
       && !all(
            vapply(
                dots
              , function(x) is.symbol(x) || is.character(x), NA, USE.NAMES = FALSE
            )
         )
  ) stop("... must contain names or character strings")

  names <- vapply(dots, as.character, "")
  if (length(names) == 0L) names <- character()


  # ABOVE HERE: This is beginning to the `base::rm()` function

  items <- c( names, list )
  items <- as_cached_path(items)

  fs::file_delete(items)
  manifest_rm(items)

}


#' @rdname cache_rm
#' @export

cache_rm_all <- function()
  cache_rm( cache_ls() )

# Previous definition

# cache_rm <- function( ..., .cache=cache_path() ) {
#
#   items <- as.character( substitute( list(...) ))[-1]
#
#   li <- list(...)
#   if( length(li)==1 && is.character(li[[1]]) )
#     items <- li[[1]]
#
#   # re.exts <- backends_exts() %>% as_regex()
#
#   items %>% as_cached_path() %>% fs::file_delete()
#   items %>% manifest_rm()
#
# }



