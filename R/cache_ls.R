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
#' @export

cache_ls <- function( cache=cache_path(), ... ) {

  re.exts <- backends_exts() %>% as_regex()

  message( "cache backends: ", crayon::blue( collapse( backends_ls(), ", " ) ) )

  fs::dir_ls( path=cache, ... ) %>%
    # fs::path_file() %>%
    as_cached_name() %>%
    unname() %>%
    unique() %>%
    na.omit() %>%
    sort() %>%
    as_cached_name()
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
