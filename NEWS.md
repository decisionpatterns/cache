# cache 0.2.4

 - Add `key` argument to `cache_use_sodium()`
 - Fix `cache_write_rds` so that it doesn't use fs::path_set_ext. That messed 
   with valid R objects with a `.` in the name.

# cache 0.2.3 

 - Fix `uncache`: file extensions work correctly now -- '.' is permitted.

# cache 0.2.2

 - Fix `uncache` to use *sodium* and other generic backends

# cache 0.2.0 

*cache* has been refactored to be more generic in how it handles file types. It
now depends on the fs package and supports RDS and AES formats.
 
 -

# cache 0.1.7 
 
 - `use_cache` added ... and now does the right thing for all project types

# cache 0.1.6

 - `cache` now returns object invisibly for use in pipes.
 - `uncache` now returns object invisibly for use in pipes.

# cache 0.1.0

 - Added a `NEWS.md` file to track changes to the package.
