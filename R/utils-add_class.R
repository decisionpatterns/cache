# Taken from base.tools

# Add class
#
# Extends an object by adding one or more classes to an object
#
# @param x object
# @param class character vector of class names
#
# @details
#
# `add_subclass` adds classes to the **front** of the class vector
#
# @return
# object with added class
#
# @md
# @rdname add_class
# # @export

add_subclass <- function(x=NULL, class) {
  if ( class %in% class(x) ) return(x)   # Already in that class
  structure( x, class = c(class,class(x)) )
}

#@details
# `add_superclass` adds classes to the end of the special `class` attribure
#
# @rdname add_class
# @export

add_superclass <- function(x, class) {
  if ( class %in% class(x) ) return(x)   # Already in that class
  structure( x, class=c(class(x),class) )
}

# @details
#  `add_class` is an alias for `add_subclass`.
# @rdname add_class
# @export

add_class <- add_subclass
