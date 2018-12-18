#' cached
#'
#' subclass for working with cached objects: path, dir, file, name, ext, etc.
#'
#' @param x object to subclass
#'
#' @details
#'
#' These are essentially used for providing special methods for cache objects vs
#' their **fs** counterparts.
#'
#' The biggest difference is *cached* ext vs a fs extension
#'
#' @export

cached <- function(x, ...) UseMethod('cached')

#' @rdname cached
#' @export
cached.default <- function(x,...)
  add_subclass( as.character(x), 'cached')

#' @rdname cached
#' @export
print.cached <- function(x, ...) {
  cat('A cached', class(x)[[2]] %>% squote(), ': ' )
  x %>%
    unclass() %>%
    crayon::red() %>%
    # squote() %>%
    collapse_comma() %>%
    cat()

  invisible(x)
}
