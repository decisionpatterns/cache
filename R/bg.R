#' Pipeable perform in the background
#'
#' Performs function according to future::plan()
#' @param x; first
#' @param fun functon to execute in the background
#'
#' @details
#'
#' `bg` executed function `fun` in the backgrodn
#'
#' @seealso
#'   - [future::future()] and [future::plan()]
#'
#' @examples
#'
#'   plan(multiprocess)
#'   f <- 5 %>% future({Sys.sleep(.)})
#'   t <- 5 %>% bg(Sys.sleep)
#'
#' @importFrom future future

bg <- function( x, fun, ... ) {

  fut <- future::future({ fun(x, ... ) } )
  attr(x, 'bg') <- fut

  add_class(x, "bg")

}

print.bg <- function(x, ... ) {

  message("bg:")

  x ->.;
    remove_class(., "bg") ->.;
    remove_attr(., "bg") ->.;
    print(.)

  invisible(x)

}


# make_bg_fun <- function(fun, ... ) {
#
#   function(fun) {
#     x <- future({fun(...)})
#     attr(x, 'bg' ) <-
#   }
# }
