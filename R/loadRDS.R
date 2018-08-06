#' loadRDS
#'
#' \code{load}-like functionality for RDS files.
#'
#' @param file character; a path to a file
#' @param envir environment; the environment where the data should be loaded
#' @param verbose logical; whether to emit detailed output
#' @param ... additional arguments passed to \code{\link{readRDS}}
#'
#' @param dir character; a path to a directory
#' @param pattern character; patterns for matching RDS files, default ".rds$"
#' @param recursive logical; whehter to recurse into sub-directories.
#'
#' \code{loadRDS} loads an individual {RDS} file; \code{loadRDSdir} loads all
#' the rds files from a directory.
#'
#' A limitation with readRDS as opposed with loadRDS is that it requires a
#' name assignment. Very often that it is inconvenient. This assigns the
#' filename to the basename of the file with the extension removed.
#'
#' @seealso
#'   \code{\link[base]{readRDS}} \cr
#'   \code{\link{file_basename}}
#'
#' @examples
#'  # -th
#'
# @export
# @include file_basename.R

loadRDS <- function( file, envir=parent.frame(), verbose=FALSE, ... ) {
  file <- as.character(file)
  file_basename(file, extension=FALSE )
  assign( file_basename(file, extension=FALSE ), readRDS(file, ...), envir=envir )
}


#' @rdname loadRDS
#' @export
loadRDSdir <- function( dir, pattern=".rds$", envir=parent.frame(), recursive=FALSE, ..., verbose = FALSE ) {

  dir <- as.character(dir)
  if( ! dir.exists(dir)) stop( "Directory", dir, "does not exist." )

  for( f in dir( dir, full.names=TRUE, pattern=pattern, recursive=recursive ) ) {
    if(verbose) message( "Loading ...", f )
    assign( file_basename(f,extension=FALSE), readRDS(f), envir=envir )
  }
}
