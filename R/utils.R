#' Find the root, returning NULL if it is not safe
#'
#' Attempts to find the root returning NULL if it fails
#'
#' @param ... arguments passed to [rprojroot::find_root()]
#'
#' @note this function is not exported
#' @import rprojroot

find_root_safe <- function(...) {
  x <- NULL
  try( x <- find_root(...), silent=TRUE )
  return(x)
}


# Lifted from devtools
union_write <- function (path, new_lines)
{
  if (file.exists(path)) {
      lines <- readLines(path, warn = FALSE)
  } else {
      lines <- character()
  }
  all <- union(lines, new_lines)
  writeLines(all, path)
}


# use_git_ignore <- function (ignores, directory = ".", pkg = ".", quiet = FALSE)
# {
#   # pkg <- as.package(pkg)
#   paths <- paste0("`", ignores, "`", collapse = ", ")
#   if (!quiet) {
#       message("* Adding ", paths, " to ", file.path(directory, ".gitignore") )
#   }
#   path <- file.path(pkg$path, directory, ".gitignore")
#   union_write(path, ignores)
#   invisible(TRUE)
# }
#
# use_build_ignore <- function (files, escape = TRUE, pkg = ".")
# {
#   pkg <- as.package(pkg)
#   if (escape) {
#       files <- paste0("^", gsub("\\.", "\\\\.", files), "$")
#   }
#   path <- file.path(pkg$path, ".Rbuildignore")
#   union_write(path, files)
#   invisible(TRUE)
# }

get_option <- getOption


#' (Pipeable) set single options
#'
#' @return
#'   The options value, invisibly
#'
#' @examples
#'
#'  x <- set_option( cache_key = "my key" )
#'  x
#'  getOption("cache_key")
set_option <- function(...) {

  li <- list(...)

  if( length(li) != 1 ) stop("Options must be a single name/value pair.")
  if( is.null(names(li)) ) stop( "Options must be named")

  options(...)

  invisible( li[[1]] )
}


# Extensions
# Glob a path in the style of `fs`
path_glob <- function(path) {
  path ->.;
    base::Sys.glob(.) ->.;
    fs::as_fs_path(.)
}

