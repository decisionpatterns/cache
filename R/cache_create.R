#' cache_create
#'
#' Create a directory for files
#'
#' @param path path to create cache directory
#'
#' @details
#'
#' Create a cache directory at `path`. If the path already exists, a warning is
#' provided.
#'
#' @importFrom here here
#' @export

cache_create <- function(
  path = here::here() %>% fs::path( cache_name() )
) {

   path <- fs::path(path)  # If not path

   if( ! fs::dir_exists(path) ) {
     message( "Creating cache ... ", path )
     fs::dir_create( path, recursive = TRUE )
     options( cache=path )
   } else {
     warning( "Directory ", path %>% squote(), " already exists." )
   }

}
