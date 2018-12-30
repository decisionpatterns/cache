#' cache_check
#'
#' Check the cache for problems
#'
#' @param cache string or path.  (Default: cache_path())
#'
#' @details
#'
#' `cache_check` checks the cache for potential problems.
#'
#' @seealso
#'
#'  - [cache_path()]
#'
#' @export

cache_check <- function( cache=cache_path() ) {

  message("This functionality is still under development.")

   # Check Unsupported files
  unsupported <- unsupported_paths(cache)
  if( length(unsupported) > 0 )
    warning( "There are no backends for files:"
             , unsupported %>% sQuote() %>% collapse_comma()
    )

  # Check Conflicts
  cache_ls()

}
