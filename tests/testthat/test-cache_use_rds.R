library(fs)

context("cache_use_rds")


cache_use_rds()
cache_delete()
cache_create("cache")
cache(iris)

test_that("Testing RDS", {

  expect_true( fs::file_exists("cache/iris.rds") )

})
