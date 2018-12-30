# DESIGN.md

This document records design decisions for the *cache* package.skeleton

## Introduction 

The cache package allows the user to save and restore files *unambiguously* and 
*robustly* with only a few simple commands regardless of the mechanism for 
doing so. 

At the heart of this is ensuring uniqueness of data files. 

## Goal(s)

 - Create pragmas for managing data (tables)
 - Hide complexity of paths and naming
 - Provide mechanism for all I/O and saving
 - replace `save`
 - Provide metadata data
 - Mimic functions of fs::
 - Create **infrastructure** for update/sync of data
 - Create **infrastructure** for supporting models esp. offline features.

The goal is to have the developer or program work with names and not worry about
paths, extension, i/o, etc.   


## `write`/`read` vs. `save`/`load` vs. `cache`/`uncache`

This package delineates the difference between `write`/`read`` and
`save`/`load`. This mostly comports to existing distinctions.

 - `save` and `load` refers to storing as a binary/non-editable file.
 - `write` and `read` refers to storing as a human-readable file.
 - `cache`/`uncache` referes to a universal storing of an object.


## Cache usage

Examples:

     create_cache() 
     
     cache(x)
     cache('x')
     cache(x, file="cache-file" )
     cache_rds(x)    # If supplied
     cache_sodium(x)

     uncache(y)


## Relations of Things

     R object (w/ name <==> filename <==> path cache_path()/cache_filename(object)
     fs:       filename <==> fs_path <==> fs_path 
     cache:
       =>      as_cached_name => add_extension => check_conflicts => path( cache_path, . ) 
               
       <=      as_cached_name => add_extension => check       
      
     cache(name) => path+ext => path( cache_path, . ) => ...
     uncache(name) => 

     backend: 
      - name
      - object (i.e. list)

  There are also "potential files" ... those that don't exist


## Method/function prefixes

 - `cache_`
 - `backend_`


## Accessor method

The packages uses the single-accessor style. Rather than have seperate `get_` 
and `set_` methods, one method is used. These functions getter unless and 
argument is supplied. This may change in the future.

The problem with the single accessor method is that it only works well on 
setting/getting simple attributes such as those that are just a string. 

## Uniqueness

In order to work properly, cache enforces uniqueness of objects. Since, there 
can only object for a given name in memory, there can only be one file 
associated with that object. This is mananged associated backends to file 
extensions. For example, `my_data.tsv` and `my_data.rds` cannot both 
simultaneously exist on the file system since the call to `uncache(my_data)` 
wouldn't know whether to read the `.tsv` or the `.rds` file. It promotes the 
user to adequately name their objects.

Note: Is this strictly necessary? 
 - What if we allowed multiple files?
 - What if this was optional?

There can be only one object with a given name regardless of the methods
of storage.  


## cache uses NSE / uncache uses SE

Why? 

  cache(iris)
  uncache('iris')


## Functional and non-functional interface(s)




### pipe-able

Where possible, *cache* 

  mtcars %>% cache %>% nrows



## Type-preserving

All cache and uncache routines should preserve data types and classes. 


## backend

A backend is much like a storage driver or an ODBC data source. It tells how to 
store and retrieve data but relies on the package functions to execute 
the backend's functions.


## files

Files are more like individual extensions.  Writing and files should be uniquely described by their file extension. This
might be true of other repositories as well, e.g. 'my_file.sql'

Files should contain the cached data, but may also contain metadata about how 
the information was retrieved or how it could be updated. 



## options

 - cache.backends
 - cache.default
 

## Update: Fact table 

A fact table is characterized by a record containing a index (usually time). To
update:

 1. Get max of index
 2. Delete everything >= index.
 3. Retrieve records >= index.
 4. Append records
 5. Save.
 
## Update: Dimension Table

A dimension table is often small and an update is a full collections

## Update: Slowly Changing Dimension
 
 - Get entire SCD if feasible
 - Get based on SCD Effective Column
 
## Dimension

Often the microcosm will be based on a sampled set of records from a given 
dimension, such as users. The microcosm should use this to filter all other
records.
