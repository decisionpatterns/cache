# TODO

 - Make an S3 Method so that different objects can have different caching mechanisms; for example table structure
   can use feather where as other structures might use RDS (DEFAULT)
 
 - Support non-local persistence; Sharable persistence
 
 - Support timestamp / versioning / tagging 
   - Support file system extened attributes for those items that need access, but not 
   - Do tags become attributes of an object (?)   


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

   

