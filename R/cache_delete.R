#' Delete cache directory
#'
#' Delete cache directory including all persisted files and metadata
#'
#' @param path cache directory path; defaults to [cache_path()]
#' @param warn logical; enable warnings
#'
#' @details
#'
#' `cache_delete` unceremoniously deletes the cache including all persisted
#' files and metadata.
#'
#' @seealso
#'   - [cache_rm()] : for removing individual objects from cache
#'   - [cache_rm_all()] : for removing all objects from cache but keeping the directory
#'   - [fs::dir_delete()] : which is used by `cache_delete`
#'
#' @export

cache_delete <- function( path=cache_path(), warn=FALSE ) {

  if( is.null(path) ) {
    if( warn )
      warning("Attempt to delete an undefined cache. ",
              "You can define it with `use_cache` or `cache_path`.")
  } else {
    if( fs::dir_exists(path) )
      fs::dir_delete( path=path )
    else if(warn) warning("Cache path, ", path, ", does not exist" )
  }

}
