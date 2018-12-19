# Find the root, returning NULL if it is not safe
#
# Attempts to find the root returning NULL if it fails
#
# @param ... arguments passed to [rprojroot::find_root()]
#
# @note this function is not exported
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

is.string <- function (x) is.character(x) && length(x) == 1
