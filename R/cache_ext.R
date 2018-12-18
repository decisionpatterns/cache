#' extension for cache files
#'
#' The filename extension used for the current backend.
#'
#' @details
#'
#' `cache_ext()` returns the extensions associated with the default cache
#' backend. The difference between a *fs* and *cache* extension is that the
#' *cache* extension may contain the `.`.
#'
#' @return
#'   An [ext()] object for the current backend.
#'
#' @seealso
#'  - [cache_backend()]
#'
#' @examples
#'   cache_ext()
#'
#' @export

cache_ext <- function() {
  ext( backend_ext( cache_backend() ) )
}
