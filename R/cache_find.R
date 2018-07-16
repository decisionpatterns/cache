#' cache_find
#'
#' Finds cache by searching up the directory structure
#'
#' @seealso
#'   [rprojroot::find_root()]
#'
#' @export

cache_find <- function(path = ".") {
    find_root_safe( criterion=has_dir('cache'), path=path )  ->.;
      file.path( ., cache_name() )
}
