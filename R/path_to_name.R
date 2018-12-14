#' path_to_name
#'
#' Convert path(s) to name(s)
#'
#' @param path character; one or more paths to convert to object names
#'
#' @details
#'
#' Finds the (object) names associated with a path. The name is discovered by
#'
#' @return
#'   named character vector; filename => object name
#'
#'
#' @note `path_to_name` is not exported

path_to_name <- function( path= fs::dir_ls( cache_path() ) ) {

  exts <- backend_exts()        # Available backend extensions
  exts <- exts[ exts %>% nchar() %>% order() %>% rev() ]  # Order by longest
  exts.re <- ext_to_regex(exts) # Backend exts regular expressions
  ret <- c()

  for( p in path ) {
    for( re in exts.re ) {

      path.file <- fs::path_file(p)  # filename portion of path

      if( str_detect( path.file, re ) ) {
        nm <- stringr::str_replace( path.file, re, '' )
        ret. <- structure( nm, names=path.file )
        break()  # FOUND IT
      }

    }

    if( ! exists('ret.') )
      ret. <- structure( NA_character_, names=path.file )
    ret <- c( ret, ret. )
    rm( ret. )
  }

  ret

}


name_to_file <- function(name)
  paste0(name, ".", backend_get(backend())$ext )


name_to_path <- function(name) {
  # name <- as.character(substitute(name))
  path(  cache_path()
        , name_to_file(name)
  )
}



#' Filter/grep files by exts

filter_exts <- function( name, ext=backend_exts() )  {
  x <- path_to_name()
  path <- x[ x == name ] %>% na.omit %>% names()
}



#' path_to_ext
#'
#' @param path

path_to_ext <- function( path=fs::dir_ls(cache_path()), exts=backend_exts() ) {

  # exts <- backend_exts()        # Available backend extensions
  exts <- exts[ exts %>% nchar() %>% order() %>% rev() ]  # Order by longest

  for( p in path ) {         # For each path
    for( ext in exts ) {   # Try each ext (in order)

      re <- ext_to_regex(ext)        #
      path.file <- fs::path_file(p)  # filename portion of path

      if( str_detect( path.file, re ) ) {
        nm <- stringr::str_replace( path.file, re, '' )
        ret. <- structure( ext, names=path.file )
        break()  # FOUND EXTENSION -- STOP SEARCHING
      }

    }

    # NA for missing extensions
    if( ! exists('ret.') )
      ret. <- structure( NA_character_, names=path.file )

    if( ! exists('ret') )
      ret <- ret. else ret <- c( ret, ret. )

    rm( ret. )
  }

  ret

}

file_to_ext <- path_to_ext
