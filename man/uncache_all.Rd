% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/uncache_all.R
\name{uncache_all}
\alias{uncache_all}
\title{Uncache all objects}
\usage{
uncache_all(
  envir = parent.frame(),
  overwrite = getOption("uncache.overwrite", TRUE)
)
}
\arguments{
\item{envir}{where to uncache the objects (Default: parent.frame()}

\item{overwrite}{logical; whether to overwrite existing objects}
}
\description{
uncache all objects on the cache
}
\seealso{
\itemize{
\item \code{\link[=uncache]{uncache()}}
\item \code{\link[=cache]{cache()}}
\item \code{\link[=cache_all]{cache_all()}}
}
}
