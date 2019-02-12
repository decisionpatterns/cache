#' filename/path extension
#'
#' Get the path or file extension allowing for extensions containing `.`
#'
#' @param path object such as character, vector, ; values to be converted to character. Character values
#' should omitting the leading `.` (period)
#' @param exts optional list of extensions, used when the extension contains a `.`
#'
#' @details
#'
#' [ext()] returns the extension of a file or path object. `ext` returns (the first of):
#'  - extension matching the `exts` arguments which uses the `fs.exts` argument by default.
#'  - character vector after final period.
#'
#' The [fs::path_ext()] takes only the considers the last.
#'
#'
#' @return a [fs_ext()] object.
#'
#' @seealso
#'  - [fs::path_ext()] - This is nearly identical but does not allow extensions
#'     containing `.` (periods).
#'
#' @examples
#'
#'   files <- c("log.tar.gz","log.tar","log.tar.bz")
#'   known_exts=c("tar.gz","tar.bz")
#'
#'   ext( files, exts=known_exts )
#'   ext( files )
#'   fs::path_ext( files )
#'
#' @importFrom fs path_ext
#' @rdname ext
#' @export

ext <- function(path, exts=getOption('fs.exts') ) {

  if( is.null(exts) ) return( fs_ext(fs::path_ext(path)) )

  exts <- exts[ exts %>% nchar() %>% order() %>% rev() ]  # Sort  by longest ext

  ret <- fs_ext()  # ext values
  for( p in path ) {          # For each path
    for( ext in exts ) {   # Try each ext (in order)

      re <- ext %>% fs_ext() %>% as_regex()
      path.file <- fs::path_file(p)  # filename portion of path

      if( str_detect( path.file, re ) ) {
        ret. <- ext # ret[[ length(ret)+1 ]] <- ext
        break()  # FOUND EXTENSION -- STOP SEARCHING
      }

    }

    # Didn't match it add NA_character_ for this path
    if( ! exists('ret.') ) ret. <- fs::path_ext(p)

    ret[[ length(ret)+1 ]] <- ret.

    rm( ret. )

  }

  fs_ext(ret)
}
