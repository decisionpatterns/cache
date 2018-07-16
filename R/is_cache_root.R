#' is_cache_root
#'
#' rprojroot criterion for finding cache directory.
#'
#' @importFrom rprojroot has_dir
#' @export

is_cache_root <- rprojroot::has_dir( cache_name() )
