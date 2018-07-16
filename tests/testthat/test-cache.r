library(testthat)
library(magrittr)
library(file.tools)

test_that( "cache", {

context('cache')

  expect_null( getOption('cache_name') ) # %>% expect_null

  test   <- "test"
  tmpdir <- tempdir()


context( ".. cache")

  cache( test, cache = tmpdir )

  rm( test )
    expect_true( "test.rds" %in% dir(tmpdir) )


context( ".. uncache")

  # Unquoted
  uncache( test, tmpdir )
    expect_true( exists("test") )
    expect_equivalent(test, "test")
    rm(test)  # clean-up

  # Quoted
  uncache( "test", tmpdir )
    expect_true( exists("test") )
    expect_equivalent(test, "test")
    rm(test)  # clean-up

  options( cache = tmpdir )
  uncache( test )
    expect_true( exists("test") )
    expect_equivalent(test, "test")
    rm(test)


context( ".. uncache_all" )

  # Clean-up
    options( cache = NULL )
    unlink( tmpdir, recursive = TRUE, force = TRUE )
})
