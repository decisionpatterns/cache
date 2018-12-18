#' List cache conflicts
#'
#' List filenames that conflict with name
#'
#' @param name quoted or unquoted name
#'
#' @details
#'
#' *cache* does not permit multiple files with the same name within a single
#' cache.  For example, you cannot have both `iris.rds` and `iris.csv`.
#' This enforces a best practice of uniquely naming your data set.
#'
#' This uniqueness is enforced among files with registered backends.
#' Thus, if there is no backend for a `.txt` file,
#' it will not be identified as conflict.
#'
#' @examples
#'
#'   conflicts(iris)  #
#'   conflicts('iris')
#'
#'   has_conflict(iris)
#'   has_conflict('iris')
#'
#' @return
#'
#'  character vector of filenames -- conflicts
#'
#  @export

conflicts <- function(name, ext=backend_ext() ) {

  name. <- as.character( substitute(name) )
  if( ! is.character(name) ) name <- name.

  exts <- backend_exts()
  exts <- setdiff( exts, ext )

  exts.re <- paste0( '^', name, '\\.', exts, '$' ) # name_to_regex
  files <- fs::dir_ls( cache_path() ) %>% fs::path_file()
  conflicts <- str_detect( files, exts.re )

  files[ conflicts ] %>% fs::path()

}


#' Determine if there is any conflicting files
#'
#' @param name string

has_conflict <- function(name, ext=backend_ext() ) {

 if( missing(name) )
   stop("A name must be supplied in order to check conflicts.")

 name. <- as.character(substitute(name))    # NSE
 if( ! is.character(name) ) name <- name.

 conflicts <- conflicts(name, ext)

 if( length(conflicts) > 0 ) TRUE else FALSE

}


conflict_msg <- function(x) {
  paste0(
    "\n  "
    , paste0( "'", x, "'")
    , " conflicts with existing files in the cache: "
    , paste0( sQuote(conflicts(x)), collapse=", " )
    , "\n"
    , "  See `?conflicts` for details."
  )
}


#' alternate_files are files that have registered extensions but are not the
#' default.
#'
#' @seealso
#'  [conflicts()]

alternate_files <- function(name) {
  exts <- backend_exts() %>% setdiff( backend_ext() )
  paste0( name, ".", exts ) %>%
    fs::path()
}

alternate_paths <- function(name) {
  name %>%
    alternate_files() %>%
    fs::path( cache_path(), . )
}
