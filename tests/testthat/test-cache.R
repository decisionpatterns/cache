library(fs)

context("test-cache")

cache_delete()
# if( dir_exists("cache") ) dir_delete('cache')

#print( getwd() )
# message( getwd() )

test_that("cache", {

  # browser()
  use_cache( path="cache" )

  cache_use_rds()
  expect_equal( cache_backend(), "rds")

  data(iris)
  i2 <- iris
  cache(i2)
  expect_true( fs::file_exists("cache/i2.rds"))
  expect_equal( as.integer( fs::file_info("cache/i2.rds")$size ) , 1080 )


  rm(i2)
  uncache(i2)
  expect_true( exists('i2') )


})


# Clean-up
fs::dir_delete( cache_path() )
