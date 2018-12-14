
#' @rdname fst
#' @export

cache_register_fst <- function()
  backend_register('fst', reader=fst::read_fst, writer=fst::write_fst, ext="fst")

if( require(fst) ) cache_register_fst()

#' @rdname fst
#' @export

cache_use_fst <- function()
  cache::backend_set("fst")
