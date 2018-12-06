# DESIGN.md

This document records design decisions for the *cache* package.skeleton

## `write`/`read` vs. `save`/`load`

This package delineates the difference between `write`/`read`` and
`save`/`load`. This mostly comports to existing distinctions.

 - `save` and `load` refers to storing as a binary/non-editable file.
 - `write` and `read` refers to storing as a human-readable file.
 - `cache`/`uncache` referes to a universal writing and reading


## uniqueness

There can be only one object with a given name regardless of the methods
of storage.


## cache uses NSE / uncache uses SE

Why? 

  cache(iris)
  uncache('iris')


## Functional and non-functional interface(s)



## Type-preserving

All cache and uncache routines should preserve data types and classes. 


## pipe-able

Where possible, *cache* 

  mtcars %>% cache %>% nrows


## files

Writing and files should be uniquely described by their file extension. This
might be true of other repositories as well, e.g. 'my_file.sql'


