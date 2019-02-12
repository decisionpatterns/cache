#' cached_file
#'
#' Object representing a file in the cache (does not have to exist.)
#'
#' @param x object
#' @param ext ext or character of allowable extensions. (Default:) or string used in the cache
#' @param ... additional arguments
#'
#' @details
#'
#' A `cached_file` is a subclass of `fs_path` object without the directory.
#' It is the filename without the path information.
#'
#' @return
#' a `cached_file` (subclass of `fs::fs_path`) object of the filename. The extension
#'
#' @seealso
#'   - [fs::path()]
#'
#' @examples
#'  cached_file('iris.rds') # e.g. "iris.rds"
#'
#'  as_cached_file('iris.rds')  # Warn: Don't include extension
#'  as_cached_file('iris', 'rds' )
#'  as_cached_file(iris)
#'
#' @import stringr.tools
# @export

cached_file <- function(x)  {
  x <- as.character(x)
  re <- backends_exts() %>% as_regex()
  wh <- x %>% str_grepv(re)
  if( length(wh)>0 )
    warning( "Files without registered extensions: ", x %>% squote %>% collapse_comma() )
  x <- fs::path_file(x)
  add_subclass(x,'cached_file')
}


#' @rdname cached_file
#' @export
print.cached_file <- function(x, ...) print_object(x,...) # NextMethod()

# print( unclass(x, ...))
# cached_file <- function(x, ext=cache_ext() ) {
#   x <- as.character( substitute(x) )  # capture as character.
#   as_cached_file(x, ext)
# }

#' @rdname cached_file
#' @export

as_cached_file <- function(x, ext=backend_exts() ) UseMethod("as_cached_file")


#' @rdname cached_file
#' @export
as_cached_file.default <- function(x, ext=backend_exts() ) {
  x <- as.character( substitute(x) )    # capture character
  as_cached_file(x, ext)
}


#' @details
#' When `x` is a **character** object, `as_cached_file` will:
#'  - convert it as-is if ending in a registered extension (may change)
#'  - coerce it to existing cached_object name if an existing `file` exists in the cache
#'  - use the default extension prodivide by `backend_exts()`
#'
#'    or **cached_name** object, cached_file
#' is looked for as:
#'  - an existing file in `cache_path()` with one of the backend extensions
#'
#'
#' @examples
#'   "iris.rds" %>% cached_file()
#'   "iris" %>% as_cached_file()
#'
#'
#' @rdname cached_file
#' @export
as_cached_file.character <- function(x, ext=backends_exts() ) {

  # Try and be smart about what is being provided.
  #if( is.null(ext) ) return( cached_file(x) )

  re.ext <- as_regex(ext)  # Regular extension for files


  ret <- c()
  for( item in x ) {

    # 1. `x``has registered extension already
    if( str_detect( item, re.ext ) ) {
      ret <- c(ret, item)
      next() # return( cached_file(x) )
    }

    # 2. Match to existing cached object.
    re.file <- paste0( "^", item, re.ext ) %>% as_regex()
    if( cache_dir() %>% str_detect(re.file) %>% any() ) {
      ret <- c( ret, cache_dir() %>% str_grep(re.file) )
      next()  # return( cache_dir() %>% str_grep(re.file) %>% cached_file() )
    }

    # 3. name + cache_exts()
    ret <- c( paste0(x, '.', cache_ext() ), ret )
  }

  cached_file(ret)

}


#' @examples
#'   "cache/iris.rds" %>% cached_path() %>% as_cached_file()
#'
#' @rdname cached_file
#' @export
as_cached_file.fs_path <- function(x, ext=NULL) {
  x <- fs::path_file(x)
  cached_file(x)
}


#' @examples
#'   cached_name('iris') %>% as_cached_file()
#'
#' @rdname cached_file
#' @export

as_cached_file.cached_name <- function(x, ext=backends_exts() ) {
  as_cached_file.character(x, ext=ext)
}
