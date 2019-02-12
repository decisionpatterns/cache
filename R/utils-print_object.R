# Simple printing of an object
# @param x object to be printed

print_object <- function(x, ...) {
  message( 'A ', red( class(x)[[1]] ), ' object: ' )
  print( attr_rm_all(unclass(x)), ... )
}
