#' cache meta directory
#'
#' The cache meta directory hold information about objects stoded in the cache
#'
#' @details
#' `meta` is a directory for holding supplementary information
#'
#'
#' @rdname meta
#' @export
meta_find <- function( cache=cache_path() ) fs::path( cache, ".meta" )


#' @rdname meta
#' @export
meta_path <- function( cache = cache_path() ) { fs::path( cache, ".meta" ) }


#' @rdname meta
#' @export
meta_exists <- function() fs::dir_exists( meta_path() )
