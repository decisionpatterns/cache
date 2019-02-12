.onAttach <- function( libname, pkgname ) {

  # suppressWarnings( try( v <- utils::packageVersion(pkgname, libname), silent = TRUE ))
  # version <- if( exists('v') ) paste0("-", v ) else ""

  dt <- read.dcf( system.file("DESCRIPTION", package = pkgname ), "Date" )
  yr <- substr(dt,1,4)
  version <- read.dcf( system.file("DESCRIPTION", package = pkgname ), "Version" )

  if( interactive() )
    packageStartupMessage(
        pkgname
      , "-", version
      , ifelse( ! is.na(dt), paste0(' (',dt,')'), '' )
      , " - Copyright \u00a9 ", ifelse(! is.na(yr), yr, '')
      , " Decision Patterns"
      , domain = NA
    )

  # if( require(future) )future::plan(multiprocess)

  # USE rds WHEN NO BACKEND LOADED
  if( is.null( cache_backend() ) ) {
    cache_register_rds()
    cache_use_rds()
  }

  # Inform of cache status/locations
  if( ! is.null( cache_path() ) ) {
    packageStartupMessage("  Using cache at: ", cache_path() )
  } else {

    if( ! is.null( cache_find() ) ) {   # UNSET AND FOUND
      cache_path( cache_find() )
      packageStartupMessage( "  Cache found at: ", cache_find() )
      packageStartupMessage( "  Change it with 'cache_path(...)'")
    } else {
      packageStartupMessage( "  Create a cache with: cache_create(...)" )
    }

  }

}

