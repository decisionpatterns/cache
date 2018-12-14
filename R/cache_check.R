#' cache_check
#'
#' Check the cache for problems
#'
#' @param cache
#'
#' @details
#'
#' `cache_check` checks the cache for potential problems.
#'
#' @export

cache_check <- function( cache=cache_path() ) {

   # Check Unsupported files
  unsupported <- unsupported_paths(cache)
  if( length(unsupported) > 0 )
    warning( "There are no backends for files:"
             , unsupported %>% sQuote() %>% collapse_comma()
    )

  # Check Conflicts
  cache_ls()

}
