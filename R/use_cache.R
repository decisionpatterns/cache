#' use_cache
#'
#' @param  path string; directory in which to place the cache
#' @param gitignore logical; whether to put `.cache`
#' @param rbuildignore
#'
#'
#' @import rprojroot
#' @export


use_cache <- function( gitignore = ignore, rbuildignore = ignore, ignore=TRUE  ) {

  # Does cache already exist.
  find_root( has_dir(".cache") )

}

# The cache path is
# 1) has_dir( ".cache"
# 2) is_rstudio_project
# 4) is_git_root

# find_root( has_dir( ".cache" ) | is_rstudio_project | is_git_root | is_r_package )
# x  <- find_root( has_dir("xxsdads"))

# root_criterion( is)

#' @importFrom rprojroot has_dir
#' @export
is_cache_root <- rprojroot::has_dir(".cachex")

#' @importFrom rprojroot find_root
find_cache <- function() rprojroot::find_root( is_cache_root )

find_cache_if <- function() {
  x <- NULL
  try( x <- find_cache(), silent=TRUE )
  return(x)
}


#' Find Root or  NULL
#'
#' Find the root or return NULL -- used when you don't know if you are in
#' a pack
#' @importFrom rprojroot find_root
find_root_safe <- function(...) {
 x <- NULL
 try( x <- find_root(...), silent=TRUE )
 return(x)

}

