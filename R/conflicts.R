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
#'  character vector of filenames that conflicts
#'
#' @importFrom stringr.tools str_escape_dot
#  @export

conflicts <- function(name, ext=cache_ext() ) {

  name. <- as.character( substitute(name) )
  if( ! is.character(name) ) name <- name.

  exts <- backends_exts()
  exts <- setdiff( exts, ext )

  exts.re <- exts %>% str_escape_dot() %>% cached_ext() %>% as_regex()
  files.re <-paste0( '^', name, exts.re )

  files <- fs::dir_ls( cache_path() ) %>% fs::path_file()
  conflicts <- str_detect( files, files.re )

  files[ conflicts ]  %>%
    fs::path()

}


#' Determine if there is any conflicting files
#'
#' @param name string

has_conflict <- function(name, ext=cache_ext() ) {

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
#' @rdname conflicts

alternate_files <- function(name) {
  exts <- backends_exts() %>% setdiff( cache_ext() )
  paste0( name, ".", exts ) %>%
    fs::path()
}

#' @rdname conflicts

alternate_paths <- function(name) {
  name %>%
    alternate_files() %>%
    fs::path( cache_path(), . )
}
