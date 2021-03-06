% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_root_safe.R
\name{find_root_safe}
\alias{find_root_safe}
\title{Find Root or  NULL}
\usage{
find_root_safe(...)
}
\description{
Find the root or return `NULL`` -- used when you don't know whether a root
can be found.
}
\examples{

\dontrun{
  find_root( has_dir("xdx") )      # ERROR!
}
  find_root_safe( has_dir("xdx") ) # NULL

}
