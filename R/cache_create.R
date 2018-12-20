#' cache_create
#'
#' Create a directory for files
#'
#' @param path path or sting to create cache directory
#'
#' @details
#'
#' Create a cache directory at `path`. If the path already exists, a warning is
#' provided. If path does not exist it is created.
#'
#' @importFrom here here
#' @export

cache_create <- function(path) {

   path <- fs::path(path)  # If not path

   # If an existing cache exists warn
   existing <- cache_find()
   if( ! is.null(existing) && fs::path_abs(path) != existing )
     warning("An existing cache has been found at: ", existing )

   if( ! fs::dir_exists(path) ) {
     message( "Creating cache : ", path )
     fs::dir_create( path, recursive = TRUE )
     cache_path( path %>% fs::path_rel() )    # Set cache as relative
   } else {
     warning( "Directory ", path %>% squote(), " already exists." )
   }

}
