#' Open Cache Directory
#'
#' Opens the cache directory
#'
#' @param cache string or path to cache directory. (Default: [cache_path()])
#' @param browser string; name of program to be used as the HTML browser.  See
#'   [fs::file_show]
#'
#' @seealso
#'  - [fs::file_show()] which this function uses
#'
#'
#' @export

cache_view <- function( cache=cache_path(), browser = getOption('browser') ) {

  if( is.null(cache) || ! fs::dir_exists(cache))
    stop("cache directory must exist.")

  fs::file_show(cache, browser)

}
