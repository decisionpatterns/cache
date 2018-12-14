#' cache_reader, cache_writer
#'
#' Get the read or write function for a path.
#'
#' @param path string; path to file.
#'
#' @details
#'
#' [cache_reader{}] and [cache_writer()] return the function for reading
#' and writing based on a given path.
#'
#' @seealso
#'  - [cache_path_ext()]
#'
#' @importFrom stringr str_detect
#' @rdname cache_reader
#' @export


cache_reader <- function()
  backend_get( backend() )$reader


#' @rdname cache_reader
#' @export

cache_writer <- function()
  backend_get( backend() )$writer


#' @rdname cache_path_ext
#' @export

cache_path_ext <- function(path) {

  exts <- getOption('cache.extensions')

  nms <- names(exts)
  nms <- nms[ order( nchar(nms), decreasing = TRUE ) ]   # order

  nms_regex <- ext_to_regex(nms)   # paste0( "\\.", nms, "$" )


  stringr::str_detect( path, nms_regex )-> .;
    which(.)[1] -> wh

  if( is.na(wh) ) {
    warning( "no reader found for ", path )
    return(NULL)
  }

  nm <- nms[wh]

  exts[[nm]]

}


# cache_exts <- cache_extensions <- function() {
#   names( getOption('cache.extensions') )
# }
#
#
# cache_path_cache_ext_remove <- function() {
#
#   exts <- cache_exts()
#   exts_regex <- ext_to_regex(exts)
#
#   cache_ls()
#
# }
