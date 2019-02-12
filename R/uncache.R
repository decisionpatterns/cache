
#' @param reader function for reading from the cache. Defaults to `cache_reader()`
#'
#' @details
#'
#' `uncache` restores an object from disk. It restores based on the name. It
#' looks in the cache
#'
#' @rdname cache
#' @import lazyeval fs
#' @export

uncache <- function(
    name
  , ...
  , envir = parent.frame()
  , overwrite = getOption('uncache.overwrite', TRUE)
  , reader
  , backend = cache_backend() %>% as_backend()  # Default backend
) {

  # GET STRING name
  name <- as.character(substitute(name))

  # cached <- cache_dir()
  if( missing(reader) )
    reader <- name %>% cached_name() %>% cache_reader()

  object <- cache_read(name, ..., reader=reader )

  # OVERWRITE! CHECK EXISTENCE
  if( ! overwrite &&  exists(name,envir=envir) ) {
    stop("Object already exists in environment. To overwrite set overwrite=TRUE.")
  }

  assign( name, object, envir = envir )  # side-effect

  return( invisible(object) )

}


#' @details
#'
#'  `cache_read()` is a functional, no side-affect version of `uncache`. It
#'  reads and returns the object. Given a name, [cache_read()] will:
#'
#'  - read the object with the default backend/extension warning if there are
#'    any alternate files.
#'  - read alternate (non-default) files with backends/extensions
#'  - alert and matching but unsupported files.
#'
#' @rdname cache
#' @export

cache_read <- function(
    name                            # string
  , cache = cache_path()
  , ...
  , reader  # defined by backend
  , backend
  # , timestamp = getOption('timestamp')
) {

  # GET STRING FOR name
  name. <- as.character( expr_find(name) )
  if( ! is.character(name) ) name <- name.

  # GET cache_reader
  if( missing(reader) )
    reader <- name %>% cached_name() %>% cache_reader()

  if( is.null(cache) || ! fs::dir_exists(cache) )
    stop( "cache does not exist: '", cache, "'" )

  # # CHECK CONFLICTS
  # # if( has_conflict(name, name %>% name_to_file() %>% file_to_ext() ) ) {
  # if( has_conflict(name, name %>% as_cached_file() %>% fs_ext() ) ) {
  #   warning(
  #     "'", name, "'"
  #     , " already appears in the cache with a different type. All cache names should be unique."
  #     , "\n  Used: ", cached_name(name) %>% sQuote()
  #     , "\n  Maybe remove: "
  #     , name %>% conflicts() %>% path( cache_path(), . ) %>% sQuote() %>% collapse_comma()
  #   )
  # }

  # Find path based on name using registered backends
  pth <- as_cached_path(name) #


  if( fs::file_exists(pth) ) {    # 1. Default Path (?)
    reader <- cache_reader(pth)
                                             # 2. Alternate Paths
  } else if( alternate_paths(name) %>% fs::file_exists() %>% any() ) {                                # 2. Alternate Paths

    alt_paths <- alternate_paths(name)

    if( length(alt_paths) > 1 )
      stop("multiple files match: \n"
           , alt_paths %>% sort() %>% sQuote() %>% paste0( " - ", . , "\n")
          )

    path <- alt_paths
    reader <- path %>%         # Look up reader from path
      as_cached_path() %>%
      as_cached_ext() %>%

      backend_get() %>%
      .$reader

  } else {                                  # 3. Unsupported paths?

    unsupported <- unsupported_paths( path = cache )

    wh <-
      unsupported %>%
        fs::path_file() %>%
        str_detect( paste0("^", name))

    unsuppored <- unsupported[ wh ]

    if( length(unsupported) == 0 )
      stop("There is no file associated with '", name, "'") else
      stop(
          "\nThere is no supported files associated with '", name, "'"
        , "\n  perhaps you need to load backend(s) for:"
        , unsupported %>% fs::path_file() %>% base.tools::squote() %>% collapse_comma()
        )

  }

  # Find reader ...
  reader(pth, ...)

}


#' @rdname cache
#' @export

uncache_ <- function(...) {

  warning( "'uncache_' is deprecated. Use 'uncache' instead." )
  uncache(...)

}
