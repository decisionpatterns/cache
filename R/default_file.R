#' @details
#'
#' Default files have a name and backend.

default_file <- function(name) {
  name %>%
    paste0( ".", backend_ext() ) %>%
    fs::path()
}

default_path <- function(name) {
  name %>%
    default_file() %>%
    fs::path( cache_path(), . )
}
