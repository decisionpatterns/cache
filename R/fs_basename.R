#' filename/path extension object
#'
#' A filename extension object allowing for extensions
#' containing `.`
#'
#' @param x object; values to be converted to character. Character values
#' should omitting the leading `.` (period)
#'
#' @details
#' [fs_basename()] provides a object for handling file/path extensions. This is
#' a character vector with a subclass `ext` that allows methods to be written
#' for it.
#'
#' @return a [fs_basename()] object.
#'
#' @seealso
#'  - [fs:path()()]
#'  - [fs::path_ext()]
#'
#' @examples
#'   fs_basename( qw(one, two, three) )
#'
#' @importFrom fs path_ext
#' @rdname ext
#' @export

fs_basename <- function(x=NULL)
  add_class( as.character(x), "fs_basename" )


#' @importFrom crayon red
#' @rdname ext
#' @export

print.fs_basename <- function(x, ...) {
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
#' `as_fs_basename` returns the extension of its argument `x`.
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
#'   file <- "my_file.rds"
#'   as_fs_basename(file)
#'
#'   file <- file %>% fs::path()
#'   as_fs_basename(file)
#'   as_fs_basename(file, c('sql', 'rds', 'sql.rds'))
#'
#' @rdname fs_basename
#' @export

as_fs_basename <- function(x, ...) UseMethod('as_fs_basename')


#' @rdname fs_basename
#' @export
as_fs_basename.default <- function(x, ... ) {
  # ext(x)
  warning(
    "There is 'as_fs_basename()' method defined for class(es): "
    , paste( class(x), collapse=", ")
    , "\nPerhaps use `ext()`` to define an extension object from a character class?"
    )
}

#' @examples
#'
#'   "iris.rds" %>%
#'
#' @rdname fs_basename
#' @export
as_fs_basename.fs_path <- function(x, exts=getOption('fs.exts') ) {
  ext <- ext(x)
  x %>% str_replace( paste0('.', ext), '' ) %>% fs_basename()

}

#' @rdname fs_basename
#' @export

path_basename <- function(x, exts=getOptions('fs.exts') )
  path(x) %>% as_fs_basename( exts )

