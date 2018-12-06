#' cache_ls
#'
#' List contents of the cache directory
#'
#' @param cache string; cache directory
#' @param ... additional arguments passed to [fs::dir_ls()]
#'
#' @details
#'
#' Similar to `ls` but defaults to viewing the cache directory.
#'
#' @seealso
#'
#'  - [cache()], [uncache()]
#'  - [fs::dir_ls() ]
#'
#' @import fs
#' @export

cache_ls <- function( cache=getOption('cache', 'cache'), ... ) {
  fs::dir_ls( path=cache, ... ) ->.
    fs::path_file(.) ->.
    fs::path_ext_remove(.) ->.
  .
}



#' @export
#' @rdname cache_ls

cache_dir <- cache_ls


#' @export
#' @rdname cache_ls
cache_info <- function( cache=getOption('cache', 'cache'), ... )
  fs::dir_info( cache )
