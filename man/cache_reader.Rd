% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cache_reader.R
\name{cache_reader}
\alias{cache_reader}
\alias{cache_reader.NULL}
\alias{cache_reader.fs_ext}
\alias{cache_reader.fs_path}
\alias{cache_reader.cached_name}
\alias{cache_writer}
\title{Get Caching Functions}
\usage{
cache_reader(x = NULL)

\method{cache_reader}{`NULL`}(x)

\method{cache_reader}{fs_ext}(x)

\method{cache_reader}{fs_path}(x)

\method{cache_reader}{cached_name}(x)

cache_writer()
}
\description{
Get the reader or writer function for a path
}
\details{
\code{cache_reader()} and \code{cache_writer()} return the function for reading
and writing to/from the cache.
}
\examples{
  cache_reader()

  cache_reader( fs_ext('rds') )

  path( "cache/iris.rds") \%>\% cache_reader()

  'iris' \%>\% cached_name() \%>\% cache_reader()

}
\seealso{
\itemize{
\item \code{\link[=cache_backend]{cache_backend()}}
}
}
