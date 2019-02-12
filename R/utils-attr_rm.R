attr_rm <- function(x, which) {
  attr(x,which) <- NULL
  return(x)
}


#' @rdname attr_rm
#' @export
attr_rm_all <- function(x) {

 wh <- names( base::attributes(x) )
 for( w in wh ) attr(x,w) <- NULL

 x

}
