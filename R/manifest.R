#' @title cache manifest
#'
#' An account of cached objects
#'
#' @details
#'
#' The manifest is the record of cached objects. It is simply a named list. The
#' names Each
#' element is a list of attributes associated with the object and is given the
#' same name as the object. The primary function of the manifest is to maintain
#' a mapping of object names to filenames and is checked to maintain uniqueness.
#'
#' Whenever objects are added or removed from the cache, the MANIFEST is updated.
#' It should always match the objects saved in the cache directory.
#'
#' Internally, the manifest is stored as a YAML file and is located at
#' `meta_path()/MANIFEST` usually `cache/.meta/MANIFEST`.
#'
#' @seealso
#'  - [meta]
#'
#' @rdname manifest
#' @export

manifest_path <- function() {
  path( meta_path(), manifest_name )
}

#' @rdname manifest
#' @export
manifest_exists <- function() fs::file_exists( manifest_path() )


#' @rdname manifest
#' @export
manifest_create <- function( overwrite = FALSE ) {

  if( ! overwrite && manifest_exists() )
    stop( "Manifest exists; use 'overwrite=FALSE' to clobber.")

  # write_rds( list(), manifest_path() )
  yaml::write_yaml( list(), manifest_path() )
}

# manifest_read <- function()  read_rds( manifest_path() )
# manifest_write <- function( object, ...) write_rds(object, path=manifest_path(), ascii=TRUE, ... )

#' @rdname manifest
#' @importFrom yaml yaml.load_file
#' @export

manifest_read <- function() yaml.load_file( manifest_path() )


#' @rdname manifest
#' @export
manifest_get <- function()
  if( manifest_exists() )
    manifest_read() else
    list()


#' @rdname manifest
#' @export
manifest_write <- function(object) yaml::write_yaml(object, manifest_path() )




#' @rdname manifest
#' @export
manifest_rm <- function(name) {

    manifest <- manifest_get()

    manifest[[name]] <- NULL
    manifest_write(manifest)

}

# #' @param ... key-value pairs. The key should be the objects name and the value
# #'   the set of values that define the object.
# #'
# #' @details
# #' `manifest_add` writes an key-value object to the manifest. The key should be
# #' the name of the object.
# #'
# #' @rdname manifest
# #' @export
# manifest_add <- function(...) {
#
#   dots <- list(...)
#   manifest <- manifest_get()
#
#   for( i in 1:length(dots) )
#
#
# }
#
#
#   manifest <- manifest_get()
#   manifest[[name]] <- list(
#       name = name
#     , path = path
#     , pkg  = be$pkg
#     , backend = backend
#     , mtime = Sys.time() %>% format( tz="UTC" )
#   )
#
#   manifest_write(manifest)
#

#' @details
#' `manifest_rebuild` rebuilds the manifest by attempting to
#'
#' @rdname manifest
#' @export

manifest_rebuild <- function() {
  # stop("Rebuilding of the manifest is not implemented yet.")
}


manifest_name <- "MANIFEST"  # filename for the manifest; can be converted to
                             # an option such with cache_name

