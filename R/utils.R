#' Find the root, returning NULL if it is not safe
#'
#' Attempts to find the root returning NULL if it fails
#'
#' @param ... arguments passed to [rprojroot::find_root()]
#'
#' @note this function is not exported
#' @importFrom rprojroot find_root

find_root_safe <- function(...) {
  x <- NULL
  try( x <- rprojroot::find_root(...), silent=TRUE )
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
#'   The option value(s), invisibly
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


`%!in%` <- function(e1, e2) ! e1 %in% e2


squote <- function (x) {
    opt = getOption("useFancyQuotes")
    options(useFancyQuotes = FALSE)
    ret <- base::sQuote(x)
    options(useFancyQuotes = opt)
    return(ret)
}

#' Collapse *vector* to a *string*.
#'
#' Collapses a vector (coercing to character if necessary) into a string.
#'
#' @param x  R objects to be collapsed, converting to character vectors as
#' necessary.
#' @param sep an optional character string to separate the results.
#'
#' @details
#' This is implemented as
#'   \code{ Reduce( function(x,y) paste(x,y, sep=sep), x ) }
#'
#' and is different from paste as this operates on a single vector rather than
#' a list of vectors.
#'
#' @seealso
#'   [base::paste()] or [base::paste0()] with argumetn `collapse=''`
#'   \code{\link[base]{paste0}} with \code{collapse=""}
#'   (Why is this different than paste?)
#'
#' @examples
#'
#'  collapse( letters )
#'  collapse( letters, sep=" ")
#'  collapse( letters, ", " )
#'  collapse_comma( letters )
#'
#'  \dontrun{
#'    collapse( 'a', 'b', 'c' )  # error
#'  }
#'
#' @keywords manip
#' @export

collapse <- function( x, sep='' ) UseMethod('collapse')

#' @export
collapse.default <- function( x, sep='' )
  collapse( as.character(x), sep=sep )


#' @export
collapse.character <- function( x, sep='' )
  Reduce( function(x,y) paste(x,y, sep=sep), x )


#' @details
#' `collapse_comma()` uses a sep argument of '`, `' (commma and a space). This
#' is mostly useful for pretty printing and code legibility.
#'
#' @rdname collapse
#' @export

collapse_comma <- function(x)
  collapse( x, sep=", ")
