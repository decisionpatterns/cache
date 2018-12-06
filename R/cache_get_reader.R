#' cache_get_reader, cache_get_writer
#'
#' Get the read or write function for a path.
#'
#' @param path string; path to file.
#'
#' @details
#'
#' [cache_get_reader{}] and [cache_get_writer()] return the function for reading
#' and writing based on a given path.
#'
#' @seealso
#'  - [cache_path_ext()]
#'
#' @importFrom stringr str_detect
#' @rdname cache_path_ext
#' @export


cache_get_reader <- function(path)
 cache_path_ext(path)$reader

#' @rdname cache_path_ext
#' @export

cache_get_writer <- function(path)
  cache_path_ext(path)$writer


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






cache_exts <- cache_extensions <- function() {
  names( getOption('cache.extensions') )
}


cache_path_cache_ext_remove <- function() {

  exts <- cache_exts()
  exts_regex <- ext_to_regex(exts)

  cache_ls()

}


path_cached_name <- function(path) {

}

cache_ext_remove <- function() {

}
