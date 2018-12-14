#' Convert ext to regex
#'
#' Converts an ext to regex
#'
#' @param ext string
#'
#' @details
#'
#' Creates a regular expression out of an extension. This will match the end
#' of a file. It has to be a regex rather than fixed in order to match to the
#' end of the filename.
#'
#' @seealso
#'  - [stringr::regex()]
#'
#' @examples
#'
#' ext_to_regex("rds")     # "\\.rds$"
#'
# @export

ext_to_regex <- function(ext) {
  regex <- paste0( "\\.", ext, "$" )
  # regex <-str_replace( regex, ".", "\\.")
  regex
}
