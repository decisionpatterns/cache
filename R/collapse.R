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
