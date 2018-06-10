# TODO


`
 - [ ] All cache to be used in pipe chain 
   - [ ] use `name` or `file` or argument
   - [?] cache to return object invisibly so that this is possible
      dat <- con %>% dbGetQuery(sql) %>% cache
   

 - [ ] cache data.frames using feather by default 

 - Functions for: 
    - (un)cache_local | cache_project
    - (un)cache_user (~/.rcache)
    - (un)cache_global 
    - Also for `_git`, `_package`, etc.

 - [ ] cache asynchronously. 
       When cache is called, this should return -okay- invisible object 
       before writing

 - [ ] cache to memory using a cache environmen
       this just does an assignment when the cache is a environment
       
 - [ ] cache:::store, cache:::restore for explicit calling
   How does packrat work it so that packrat::XDX works but XDX does not?
   It doesn't

 - [ ] Would it be possible to have cache emulate an on-disk **environment**
       such that an access to an object would recall it from disk and 
       write it back there.

       A environment object could be directly tied to an on-disk object.
       
       Assignment back to the object .... or any change to the object would
       write it back to disk. In fact, we can have a valid REPL, invalidate
       objects and free resources, swapping them out to disk.  

       WAIT. Isn't that just swapping. No. It isn't. It's more intelligent, 
       you are swapping based on ....
       

 - [ ] Change cache to a `.predicate` style interface 

    cache( all_tables() ) 
    cache( all_data.frames() ) 

 - [?] Create `cache_ls` as an alias for `cache_dir`; cache::ls() 

 - Change default cache to
   - use rprojroot
   - .cache? ~/.cache?  
   - The cache should be part of the project by default
   - It should be .gitignore'd
   - It can be part of packrat (really no choice)
   - `use_cache()`

  - cache_mv ?
    - to move cache?
    - to move objects within cache?  cache_rename 
  
 - Make cache an S3 Method so that different objects can have different caching mechanisms; for example table structure. This could require an internal method .cache
   can use feather where as other structures might use RDS (DEFAULT)
 
 - Support non-local persistence; Sharable persistence, e.g. REDIS
 
 - Support timestamp / versioning / tagging 
   - Support file system extened attributes for those items that need access, but not 
 - Do tags become attributes of an object (?)  
 - In some ways this would be equivalent to a bigtable and why might consider
     making this analogous to uber's schemaless
 - [ ] use lazyeval 

 - [ ] Support cache non-op for turning off saving of cache. This might be achievable through the specification of a cache function such as `cache.nonop` 


## uncache

 - Should return TRUE if object exists and was loaded successfully 
 - [x] Use lazyeval::expr_find %>% as.character
 - [ ] Support timestamps and identifies most recent timestamp
 - [-] `try_uncache_` to return TRUE/FALSE on success/failure to test if uncaching is successful.
   - 
 - [ ] use rprojroot to find `cache/` 
 - [ ] support timestamp to un/cache if newer. 
 - [ ] support multiple cache mechanisms such as rds, feather, write_table, etc. 
 - [ ] tie into rsync package ... 
## File Methods 
   - Text (delim; xlsx; txt)
     Imagine this ... where automated analysis and files are intermingled
   - RDS
   - Feather (does feather have readable metadata?) 


## Remote Methods
 - RRedis
 - DB/Remote options (Promotes Reusabilityi/Sharing)


## Integrate with synchronization  
 
 - A service might be envisioned that operates on updating the cached values automatically such that each 
   cache item is maintained at the necessary level of updatedness 

   

