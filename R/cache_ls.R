#' cache_ls
#'
#' List cached files
#'
#' @param cache string; cache directory (Default: [cache_path()] )
#' @param ... additional arguments passed to [fs::dir_ls()]
#'
#' @details
#'
#' Similar to `ls` but lists the objects in the cache directory that can be
#' loaded.
#'
#' @return
#'
#' character vector (names of objects)
#'
#' @seealso
#'  - [unsupported_paths()] and [unsupported_files()]
#'  - [cache()], [uncache()]
#'  - [fs::dir_ls()]
#'
#' @import fs
#' @import crayon
#' @export

cache_ls <- function( cache=cache_path(), ... ) {

  fs::dir_ls( path=cache, ... ) %>%
    as_cached_name() %>%
    unname() %>%
    unique() %>%
    na.omit() %>%
    sort() %>%
    # as_cached_name() %>%
    cache_list()
}

# Note we create a separate class list object so that we can have a
# print.cache_list method that provides additional information

#' @details
#' `cache_list` creates a cache_list object for which a print method can exist.
#'
#' @rdname cache_ls
#' @export

cache_list <- function(x) add_subclass(x, "cache_list")

#' @importFrom base.tools parenthesize
#' @rdname cache_ls
#' @export

print.cache_list <- function(x, ... ) {

  # Create meta informations
  msg <- c( "default backend: ", crayon::green( cache_backend() ) )
  if( ( backends_ls() %>% length() )  > 1 ) {
    bes <- backends_ls() %>% setdiff( cache_backend() )
    msg <- append( msg, ' ' )
    msg <- append( msg, bes %>% collapse(', ') %>% parenthesize() )
  }
  message( msg )

  NextMethod('print')

}



#' @details
#'
#' [cache_dir()] lists all files in the cache, supported or not.
#'
#' @export
#' @rdname cache_ls

cache_dir <- function( path=cache_path(), ... ) {
  fs::dir_ls(path, ...) ->.
  fs::path_file(.)
}


#' @export
#' @rdname cache_ls

cache_info <- function( cache=getOption('cache', 'cache'), ... )
  fs::dir_info( cache )
