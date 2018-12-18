#' unsupported_paths
#'
#' list unsupported_files, i.e. those without a registered backend.
#'
#' @param path character or [fs::path()] pointing to a directory or file.
#'             (Default: [cache_path()])
#'
#' @details
#'
#' `unsuppported_paths()` checks to see whether the paths given by `path` have
#' registered extensions and can therefore be written or read.
#'
#' We cannot get `unsupported_exts()` since we can't, in general, discern
#' where the filename ends and the extension begins.
#'
#' @return
#' character vector of unsupported paths/files.
#'
#' @seealso
#'  - [cache_path()]
#'
#' @examples
#'
#'
#' @importFrom fs dir_ls
#' @importFrom stringr str_detect
#' @importFrom stringr str_replace
#' @importFrom stringr fixed
#' @export

unsupported_paths <- function( path=cache_path() ) {

  if( fs::is_dir(path) )
    paths <- fs::dir_ls(path) else
    paths <- path

  # CREATE REGEX LIKE: ".(ext1|ext2|ext3)$"
  exts.re <-
    backend_exts() %>% # ext_to_regex()
    str_replace( fixed("."), "\\." ) %>%
    collapse("|") %>%
    paste0( "\\.(", ., ")$" )

  unsupported <- ! paths %>% str_detect( exts.re )  # NOTE !

  paths[ unsupported ]

}


#' @rdname unsupported_paths
#' @export

unsupported_files <- function(...)
  unsupported_paths(...) %>% fs::path_file()
