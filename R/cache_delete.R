#' Delete cache directory
#'
#' Delete cache directory including all persisted files and metadata
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

cache_delete <- function()
  fs::dir_delete( path = cache_path() )
