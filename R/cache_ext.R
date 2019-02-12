#' Default cache extensions
#'
#' Get the file/path extension used for the current/defaul cache backend.
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
#' @rdname cache_ext
#' @export

cache_ext <- function(x) UseMethod('cache_ext')

#' @rdname cache_ext
#' @export
cache_ext.NULL <- function(x) {
  cache_backend() %>% as_backend()  %>% .$extension %>% cached_ext()
}

