#' Defautl cached name and file
#'
#' Report default file and path given a name
#'
#' @param name string; object name
#'
#' @details
#'
#' Provides the default name and path for default cache backend.
#'
#' @export

default_file <- function(name) {
  name %>%
    paste0( ".", backend_ext() ) %>%
    fs::path()
}

#' @rdname default_file
#' @export

default_path <- function(name) {
    fs::path( cache_path(), default_file(name) )
}
