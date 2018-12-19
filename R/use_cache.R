#' use_cache
#'
#' Add a cache to a project
#'
#' @param path string; path to cache directory (DEFAULT:NULL)
#' @param ignore logical; whether to ignore both .gitignore and rbuildignore
# @param criterion *rprojroot* criterion.  See [rprojroot::find_root()]
#' @param ... unused -- requires explicit naming for `git_ignore` and `rbuild_ignore`
#' @param git_ignore logical; whether to put `cache` in `.gitignore` (DEFAULT: `TRUE`)
#' @param rbuild_ignore logical; whether to put `cache` is `.Rbuildignore` (DEFAULT: `TRUE`)

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
#' `cache_use` is an alias for `use_cache` that has the conventions of this
#' package rather than `devtools`.
#'
#' @seealso
#'  - [here::here()]
#'
#' @import rprojroot fs
#' @importFrom here here
#' @export

use_cache <- function(
    path = cache_find()
  , ignore = TRUE
  # , criterion=is_git_root | is_r_package | is_rstudio_project
  , ...
  , git_ignore = ignore
  , rbuild_ignore = ignore
) {

  if( is.null(path) ) {
    message("Putting cache in current directory: ", getwd() )
    path = "." %>% fs::path( cache_name() )
  }

  cache_create(path)

  cache_path(path)
  options( cache.name = fs::path_file(path) )

  # If this is a part of a git project ... ignore the cache's relative path
  if( git_ignore ) {
    git_root <- find_root_safe( is_git_root )
    if( ! is.null(git_root) ) {
      # path <- file.path( root, cache_path() )
      git_ignore_path <- file.path( git_root, ".gitignore" )
      cache_path_rel <- fs::path_rel( path, git_root )
      message( "Adding '", cache_path_rel, "' to '", git_ignore_path, "'" )
      union_write( git_ignore_path, cache_path_rel )
    }
  }

  if( rbuild_ignore ) {

    pkg_root <- find_root_safe( is_r_package )
    if( ! is.null(pkg_root) ) {
      rbuild_ignore_path <- file.path( pkg_root, ".Rbuildignore" )
      cache_path_rel <- fs::path_rel( path, pkg_root )
      cache_path_rel <- paste0( cache_path_rel, "/" )
      message( "Adding '", cache_path_rel, "' to '", rbuild_ignore_path, "'" )
      union_write( rbuild_ignore_path, cache_path_rel )
    }

  }

  invisible(TRUE)

}


# #' @rdname use_cache
# #' @export
#
# cache_use <- use_cache
