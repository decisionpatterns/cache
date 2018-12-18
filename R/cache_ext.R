#' cache_ext
#'
#' A extension object for a cached object
#'
#' @param x character; values to be converted to extensions omitting the leading
#'        `.`
#' @examples
#'
#'   cache_ext( qw(one, two, three) )
#'
#' @export

cache_ext <- function(x)
  add_class( as.character(x), "cache_ext" )

#' @rdname cache_ext
#' @import crayon
#' @export
print.cache_ext <- function(x, ...) {
  cat( "cache_ext: " )
  x %>%
    unclass() %>%
    crayon::red() %>%
    # squote() %>%
    collapse_comma() %>%
    cat()
}
