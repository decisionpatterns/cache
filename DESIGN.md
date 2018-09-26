# DESIGN.md

This document records design decisions for the *cache* package.skeleton

## write/read vs. `save`/`load`

This package delineates the difference between `write`/`read`` and
`save`/`load`. This mostly comports to existing distinctions.


## cache uses NSE / uncache uses SE

  cache(iris)
  uncache('iris')

## pipe-able

  mtcars %>% cache %>% nrows


## files

Writing and files should be uniquely described by their file extension. This
might be true of other repositories as well, e.g. 'my_file.sql'
