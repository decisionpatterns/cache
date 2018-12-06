#' Get the extension
#'
#' Get the *registered* cache extension string from the path.
#'
#' @param path string; path to file
#'
#' @details
#'
#' [cache_path_ext()] gets the entire extension from the cache path, either a
#' full path or simply a filename. The extension has to be known and registered
#' using [cache_add_ext()].
#'
#' @seealso
#'  - [cache_add_ext()]
#'  - [fs::path_ext()]
#'
#' @importFrom stringr str_detect
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


ext_to_regex <- function(ext) paste0( "\\.", ext, "$" )



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
