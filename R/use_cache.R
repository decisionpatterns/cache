#' use_cache
#'
#' Add a cache to a project
#'
#' @param path string; path to cache directory (DEFAULT:NULL)
#' @param ignore logical; whether to ignore both .gitignore and rbuildignore
#' @param criterion *rprojroot* criterion.  See [rprojroot::find_root()]
#' @param git_ignore logical; whether to put `cache` in `.gitignore` (DEFAULT: `TRUE`)
#' @param rbuild_ignore logical; whether to put `cache` is `.Rbuildignore` (DEFAULT: `TRUE`)
#'
#' @details
#'
#' In most cases, all you need to do is `use_cache()`. This will:
#'  - create a cache directory in your git, rstudio or r package root.
#'  - add ignore to `.gitignore`
#'  - add ignore to `.Rbuildignore`
#'
#' Arguments allow for fine tuning of the behaviors.
#'
#' `path` allows for the cache directory to be specified. If the
#' directory does not exist, it is created.
#'
#' `git_ignore` controls whether the cache is ignored by git. The default is not
#' to commit the cache data to git as the cache is seen as a working directory.
#'
#' `rbuild_ignore` controls whether the cache is incorporated into the package
#' build. The default is not to include them.
#'
#'
#' @seealso [rprojroot::find_root()]
#' @import rprojroot fs
#' @export

use_cache <- function(
    path=NULL
  , ignore=TRUE
  , criterion=is_git_root | is_r_package | is_rstudio_project
  , ...
  , git_ignore = ignore
  , rbuild_ignore = ignore
) {


  if( ! is.null(path) ) {
    root <- fs::path_dir(path)
  } else {
    root <- find_root( is_git_root | is_rstudio_project | is_r_package )
    path <- file.path( root, cache_name() )
  }

  if( ! dir_exists(path) ) {
    message("creating cache directory at: ", path)
    fs::dir_create(path)  # ...?
  } else {
    message("using existing directory: ", path)
  }

  cache_set( path )
  cache_set_name( fs::path_file(path) )

  #' If this is a part of a git project ... ignore the cache's relative path
  if( git_ignore ) {
    git_root <- find_root_safe( is_git_root )
    if( ! is.null(git_root) )
      # path <- file.path( root, cache_name() )
      git_ignore_path <- file.path( git_root, ".gitignore" )
      cache_path_rel <- fs::path_rel( path, git_root )
      message( "Adding '", cache_path_rel, "' to '", git_ignore_path, "'" )
      union_write( git_ignore_path, cache_path_rel )
  }

  if( rbuild_ignore ) {

    pkg_root <- find_root_safe( is_r_package )
    if( ! is.null(pkg_root) ) {
      rbuild_ignore_path <- file.path( pkg_root, ".Rbuildignore" )
      cache__path_rel <- file.path( path, rbuild_ignore_path )
      message( "Adding '", cache_path_rel, "' to '", rbuild_ignore_path, "'" )
      union_write( rbuild_ignore_path, cache_path_rel )
    }

  }

  invisible(TRUE)

}
