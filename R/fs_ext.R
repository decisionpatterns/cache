#' filename/path extension object
#'
#' A filename extension object allowing for extensions
#' containing `.`
#'
#' @param x object; values to be converted to character. Character values
#' should omitting the leading `.` (period)
#'
#' @details
#' [fs_ext()] provides a object for handling file/path extensions. This is
#' a character vector with a subclass `ext` that allows methods to be written
#' for it.
#'
#' @return a [fs_ext()] object.
#'
#' @seealso
#'  - [ext()]
#'  - [fs::path_ext()]
#'
#' @examples
#'   fs_ext( qw(one, two, three) )
#'
#' @importFrom fs path_ext
#' @rdname fs_ext
#' @export


fs_ext <- function(x=NULL)
  add_class( as.character(x), "fs_ext" )


#' @importFrom crayon red
#' @rdname fs_ext
#' @export

print.fs_ext <- function(x, ...) {
  message( 'A ', class(x)[[1]], ' object:')
  x %>%
    unclass() %>%
    crayon::red() %>%
    # squote() %>%
    collapse_comma() %>%
    cat("\n")

}

#' @param exts character allowable extensions
#'
#' @details
#' `as_fs_ext` returns the extension of its argument `x`.
#'
#'  If `x` is a
#'  If `x` is a *fs_path* object and `exts` is provided, x will identify
#'  extensions will match these extensions first. This allows for extensions
#'  with more than one `.` in the filename. Otherwise, [fs::path_ext()] is used
#'  and the extension is the character following the last `.` in the path or
#'  filename.
#'
#'  Missing extensions are encoded as an empty string (`""`).
#'
#'
#' @examples
#'   file <- "my_file.sql.rds"
#'   as_fs_ext(file)
#'
#'   file <- file %>% fs::path()
#'   as_fs_ext(file)
#'   as_fs_ext(file, c('sql', 'rds', 'sql.rds'))
#'
#' @rdname fs_ext
#' @export

as_fs_ext <- function(x, ...) UseMethod('as_fs_ext')


#' @rdname fs_ext
#' @export
as_fs_ext.default <- function(x, ... ) {
  # ext(x)
  warning(
    "There is 'as_ext()' method defined for class(es): "
    , paste( class(x), collapse=", ")
    , "\nPerhaps use `ext()`` to define an extension object from a character class?"
    )
}


#' @rdname fs_ext
#' @export
as_fs_ext.fs_path <- function(x, exts=getOption('fs.exts') )
  ext(x, exts)

