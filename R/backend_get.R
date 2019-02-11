#' Get backend
#'
#' Get the cache backend
#'
#' @param x
#' @details
#' `backend_get` retrieves the definition for the cache backend. The definition
#' is a list that was created by [cache_register()].
#'
#' @return
#' `backend_get` returns a list for the backend.
#'
#' @seealso
#'  - [backend()]
#'
#'@rdname backend_get
#' @export

backend_get <- function(x) UseMethod('backend_get')


#'@rdname backend_get
#' @export

backend_get.NULL <- function(x) {
  backends()[[ cache_backend() ]]
}


#'@rdname backend_get
#' @export

backend_get.fs_ext <- function(x) {
  ext <- x
  backends() %>% Filter( function(x) x$ext == ext, . ) %>% .[[1]] # %>% .$name
}


#'@rdname backend_get
#' @export

backend_get.fs_path <- function(x) {
  x %>% ext() %>% backend_get()
}

#'@rdname backend_get
#' @export

backend_get.character <- function(x) {
  backends()[[x]]
}
