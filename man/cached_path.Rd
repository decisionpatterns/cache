% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cached_path.R
\name{cached_path}
\alias{cached_path}
\alias{print.cached_path}
\alias{as_cached_path}
\alias{as_cached_path.default}
\alias{as_cached_path.character}
\alias{as_cached_path.cached_file}
\alias{as_cached_path.cached_name}
\title{Cached object's path}
\usage{
cached_path(x)

\method{print}{cached_path}(x, ...)

as_cached_path(x, cache = cache_path(), ext = cache_ext())

\method{as_cached_path}{default}(x, cache = cache_path(), ext = NULL)

\method{as_cached_path}{character}(x, cache = cache_path(), ext = backends_exts())

\method{as_cached_path}{cached_file}(x, cache = cache_path(), ext = NULL)

\method{as_cached_path}{cached_name}(x, cache = cache_path(), ext = cache_ext())
}
\arguments{
\item{x}{string or \code{\link[fs:path]{fs::path()}} object.}

\item{...}{additional arguments}

\item{cache}{string; location of the cache directory. (Default: \code{\link[=cache_path]{cache_path()}})}

\item{ext}{string; extension for the file. (Default: \code{\link[=cache_ext]{cache_ext()}} )}
}
\description{
The path for a cached object
}
\details{
A \code{cached_path} is a \code{\link[fs:path]{fs::path()}} object that points to an object in the
cache, It is not the cache directory itself.  Use \code{\link[=cache_path]{cache_path()}} for getting
and setting the location of the cache directory.
}
\examples{
  cached_path("cache/iris.rds")
  cached_path( c("cache/iris.rds", "mtcars.rds") )

  as_cached_path(iris)
  cached_file('iris.rds') \%>\% as_cached_path()

  cached_name('iris') \%>\% as_cached_path()

}
\seealso{
\itemize{
\item \code{\link[=cache_path]{cache_path()}}
\item \code{\link[fs:path]{fs::path()}}
}
}
