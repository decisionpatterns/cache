context("test-as_regex")

test_that("as_regex", {

  test <- as_regex( c("foo", "bar") )

  test %>% class() %>% expect_equal( c("regex", "pattern", "character") )
  test %>% length() %>% expect_equal(2)


})
