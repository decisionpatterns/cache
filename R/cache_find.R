#' cache_find
#'
#' Finds the cache path by searching up the directory structure for a directory
#' named by `cache_name()`.
#'
#' @param path to look for cache in. Default is the PWD.
#'
#' @details
#'
#' The default name of the cache directory is `cache`, but can be changed with:
#' `options(cache.name=*name*)`.
#'
#' @return a [fs::path()] pointing to the cache directory or `NULL` if the
#'   path cannot be found.
#' @seealso
#'   [rprojroot::find_root()]
#'
#' @import fs
#' @export

cache_find <- function(path = ".", relative=FALSE ) {
    find_root_safe( criterion=has_dir( cache_name() ), path=path ) ->.

    if( is.null(.) ) return(.)  # CAN'T FIND PATH

    fs::path( ., cache_name() ) ->.

    if( relative )
      fs::path_rel(.) ->.

    .
  }
