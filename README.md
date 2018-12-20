# cache 

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

The **cache** package provides a consistent interface for writing and
restoring data. It is designed to object permanance easy, functional, 
extensible and consistent.  

  - **easy**: there are two functions that you need, `cache` and `uncache`
  - **functional**: 
    - functions work well with pipes.
    - use for building data marts for analyses
    - replaces `ProjectTemplates` cache functionality
    - encryption built in.
  - **extensible**:
    - Add new save/load and read/write by writing your own `cache_read_*` and
      `cache_write_*` functions.
  - **consistent**
    - standard arguments and meanings
    
It should be noted that the cache exists on a per-project basis.  

Together with the 
**-tk** package. Those data sets can be saved and easily refreshed.



**NB**
This packges is not intended for importing data. Packages such
as **readr**, **foreign** or any of the database packages are well-suited for 
this purpose.


## Motivation 

A very common pattern when building models or performing analysis is to build 
ad-hoc data marts that support your analysis.

In many ways this performs a more generalized function of what 
[ProjectTempate](http://projecttemplate.net) does but in a more general and 
pipe-friendly way.



or performing analyses you would like to create
a local store of data that can improve model building and analysis. The 
**cache** package makes that easy

## Installation 

    install_github( "decisionpatterns/cache" )


## Usage 

    cache(object)    # save object to cache
    cache("object")  # same (by name)
     
    uncache(object)
    uncache(object)
     
    use_cache()    # Creates a cache directory like devtools::use_* functions
    
    
## DESIGN 

cache is designed to be modular in its ability to save and retrieve objects 


### What is a Cache?

A cache is just a *directory* for storing objects. The cache package handles the
saving and restoring of those objects.
