# TODO

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

   

