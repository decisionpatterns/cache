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
#' @note
#'
#' [cache_create()] is used to create a directory so that
#'
#' @importFrom here here
#' @export

cache_create <- function(path) {

   path <- fs::path(path)  # If not path

   # WARN before creating a new cache if an existing one already exists
   existing <- cache_find()
   if( ! is.null(existing) &&
       fs::path_abs(path) != existing
   ) {
     warning("An existing cache has been found at: ", existing )
   }

   if( fs::dir_exists(path) ) {
     stop( "Directory ", squote(path), " already exists. ",
           "To use this as the cache use: cache_path('", path, "')"
           )
   } else {
     message( "Creating cache : ", path )
     fs::dir_create( path, recursive = TRUE )
     fs::dir_create( fs::path(path, ".meta") )
     cache_path( fs::path_rel(path) )    # Set cache as relative
     cache_name( fs::path_file(path) )
   }


}
