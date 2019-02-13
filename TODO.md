# TODO

 - [ ] create a cache_list object that has a print method with messages so that
       cache_ls can be used as getting names from the 
 
 
 - [ ] decide if/whether:
       the default (cache_backend) or existing (as_cached_ext() %>% as_backend() )
       is used to save the file.  This should probably be a setting.  
       
 - [ ] change specification of `abackend` to string
 - [ ] change specification of `reader`/`writer` to string object in backend. 
 
 - [ ] convert cache/uncache and cache_write/cache_read to use backend argument 
       instead of ... 
       
 - [ ] meta_add to create `.meta` directory in `cache_path()` as part of upgrade
       to newer version.
       
 - [ ] put `bg` caching in another package
 
 - [x] Is `as_cached_ext.cached_path()` the same as `ext()`?
       No. They are subtly different.
        - `cached_ext()` has the default of `exts=backends_exts()`
        - cached_ext() represents a cached_ext object. 
        - as_cached_ext() changes/coerces with ext=backend_exts() and special 
          rules for getting the ext
        
         
 - [x] Change `ext` to `fs_ext`
       - [x] Make it work with `fs`
       - [x] `exts`: a list allowed extensions
       - [x] 'everything after the final `.` (fs default)
       - [?] `""` if no extension is given
 
 - [ ] Function for interactive loading, e.g. cache() (without args) 
       opens a ls and prompts users for which data to load.

 - [ ] uncache(file) on non-existant file errors should warn gracefully . 
 
 - [ ] Backend metadata functions similar to `fst::metadata_fst()` but with
       a consistent interface?
       metadata(iris) ... look in .meta, look in package

 - [ ] cache_rm_all() 
       Remove all items from the cache
       
 - [ ] Add command to backend?
       Really command is a data-set level thing and not a backend thing
 
 - [ ] In memory backend ... 
       store the data in a different process? sends the data to a different process?
       in a differen environment
       
 - [ ] Use .Rprofile to start-up cache (if not default)
   - Locate position of cache
   
 - Turn on object tracking for data.frames (i.e. write )
 
 - [ ] cache_info should include
       - name
       - format|backend 
       - class 
       - dim 
       - size
       - key 
       - mtime
       
 - [ ] Define function by name or expression, e.g.  
       (quote( cache::cache_ls ) %>% eval )()
       rlang::quo(cache.sodium::write_sodium) %>% rlang::quo_get_expr()
 
 - [ ] Separate connections (backends) from commands (get).
       A data set is associated with a command: read -or- write.
       The command will probably have to be stored with the **metadata** for the 
       cache. 
       .cache/metadata
       .cache/summaries 
       cache_write(iris, cmd=do_something )
 
 - [ ] `cache_path` should probably be denoted with a `.cache` file in it, to 
       unambigously tell if it is a .cache path -or- a `.cache` directory. 
       This probably entails changing how `cache_find()` works.
 
 - [ ] What is the proper `path` argument to cache_create().  A path into which 
       the cache is created -or- the path to the cache directory.  
       The later.  This is done correctly.
       
 - [ ] Autogenerate `README.md` or `README.html` for a cache directory for a
       group of files.
 
 - [ ] Perhaps we need to be able to mark a directory as a cache.
 
 - [ ] replace `base::save()` with cache mechanism
 
 - [ ] `collapse` method for regex
 
   Turns several regexs into a single regex by finding the lcs 
   (longest common subsequence)
   
   See [lcs](https://stackoverflow.com/a/33384923/1504321)
   
    #' @details
    #'   Collapse a
    #' @rdname collapse
    #' @export
    collapse.regex <- function(x, sep="|") {
    
      if( length(x)<=1 ) return(x)
    
      ...
    
    }
 
 - [ ] (low priority) ext class should be associated with a backend

       ext.backend = 'fst' 
 
 
 - [ ] Create `cache(d)` class
       The class can provide a number of methods for special objects.
       - See `cached_file.R`
       - Class has object + attribute `cache_name` for object as an attribute
       - This should handle i/o. And can be passed around.
       - See `cached.R` for some idea about developing this around `ext`
       
      `cache_write()` will unpack the object with the name attribute for writing.
      most methdos for `cache(d)` will remove the class and delegate to NextMethod.
      
       
 - [ ] Create `cache_*` method for and `fs::file_*` method:
       Should a sticky bit be set on the cache to ensure that the same
        file_access -> cache_access : is the cache readable writable
        file_chmod ->  cache_chmod : change permissions
        file_chown -> change owner : cache at a time
        X file_copy -> no copying
        X file_create
        file_delete -> cache_delete / cache_rm 
        file_exists -> cache_exists(name)
        file_info -> cache_info() 
        X file_move 
        file_show -> cache_show
        X file_temp -> 
        X file_temp_pop
        X file_temp_push
        file_touch

 - [x] cache_write should support object, name to enable something like:
       cache_write( iris[1:4,], name='iris' )
 
 - [ ] Reorganize how packages are loaded.
       cache_use(sodium) -- should:
       - load cache.sodium package
       - register the sodium backend
       - cache_default(sodium)
       cache_register(sodium)
  
 - [ ] Allow *name* or *character* or *quote* for backend reader and writer; 
       this makes it more transparent as what is happening.
       
 - [ ] supported_paths(), supported_files() 
 
 - [ ] If `sodium.rds` is not registered and `rds`, cache thinks `iris.sodium.rds`
       is a `rds` file. Perhaps it might be better to create a `.metadata` file
       that contains (among other things) a mapping from object/name to backend
       and ensure. One limitation of this approach is that the file can be 
       deleted from the filesystems without being captured in `.metadata`.
       Having the `.metadata` file or directory would mean that we always 
       know the backend associated with a file and it can be loaded by 
       `uncache()` or `cache_read()`
       
 - [ ] Support multiple extentions per backend, e.g. `.tgz` and `.tar.gz`
       This can also be handled as two separate backends and thus keep the 
       mapping of extension to backend as one-to-one.
 - [ ] Allow `cache.x` to supply multiple backends. 
 
 - [ ] List files for a given backend/extension? `cache_ls('rds')`

 - [ ] When registering a backend; check for file conflicts.

 - [ ] cache/uncache by 
   - [ ] glob or
   - [ ] regex
   These may be functions `cache_glob()` or `cache_regex()`

    cache( regex(name) )
    cache( glob(name) )  # use glob2rx
 
 - Use *crayon* or *pillar* to add color 
   - cache items without backend (red)
   - cache items without loaded backend (grey)
   - cache item with loaded backend (normal)

 - [X] dot-dot
   It may be advisable to use `..` as a filename separator for the extensions
   rather than rely on the extensions that are registered.

 - [x] Support files and paths esp fs_path objects from `fs` package
 
 - [ ] loadr
   Load a file based on extension, includes readr.
   load vs. read (?)
   - [ ] 
   
 - [ ] When rprojroot is a package, set the cache to be the data directory.
   - cache then is equivalent to `devtools::use_data()`

 - [X] Create `cache_use_fst` -> refactor to 

 - [X] Rename `cache_write_aes` -> `cache_write_sodium`, etc.s
 
 - [X] Rename `tidycache` - No.
 
 - [?] Use `secure` package for making sure that data is sharable `cache.secure`
 
 - [ ] Securely get password from terminal, cf. *getPass* package
 
 - [ ] Use `bg` to support async saving of files. It is already written but 
       unused. Can we support `bg` caching as an option/directive 
 
 - [x] Support compound file extensions, e.g. `tsv.gz` or `aes.rds`
       This is supported in the backend.
 
 - [ ] Support multiple caches (?)
   - Generally, this is supported `cache_set()` or `cache_path_set()`
   - Other functions explicitly take a `cache=` argument
 
 - [ ] Factor out 
   - [x] `cache.sodium`
   - [ ] `cache.rds` package.
   - [ ] Core `cache` package to handle cache path, dispatch and metadata 
   - [ ] Create `cache.odbc`, `cache.dbi`, `cache.feather`, packages.
   
 - [ ] Decide on whether `uncache` should be a load/restore or read function. 
   Currently it does both.
   
 
 - [ ] Object should have a save type attribute
 
 - [ ] Implement metadata (as `cache_find()/.meta` )
 
 - [ ] Use `.Rprofile` for ...
 
 - [ ] Support extensions through methods. 
   For example `cache_write.aesrds()` would be used for files with  
   A potential problem is that the writer will not no the class.
   - [ ] Create `file_type()`/`write_method`/`cache_method()`
     for declaring the method of caching the file. 
     
     name %>% cache_method() %>% uncache
     name %>% uncache_aes() 
     
     object %>% cache_method('aes') %>% cache() *or* 
     object %>% cache_aes() *or*
     object %>% cache( method = 'aes')

     
     
   > fs::path('.') %>% class()
   [1] "fs_path"   "character"
 
 - [x] Remove dependency on file.tools in favor of fs
   - [x] loadRDS
   - [x] `file_basename` -> `fs::path_ext_remove()`
   
 - [ ] Seperate encryption from saving
 
 - [x] Add `cache_read` and `cache_write` which do not do assignment
   The relative merits of load/save vs read/write
   load/save encapsulates assignment to an environment
   read/write allow specification of object name
   - [x] change to `cache_read.aes` and `cache_write.aes` --> cache_[*]_sodium

 
 - [ ] Redraft with rlang for NSE 
 
 - Delineate the difference between 
   - cache_name : basename 
   - cache_get / cache_get : 
   - cache_path 
   - cache_find # search 
   
 - [x] `use_cache()` should set-up .Rprofile to specify a project specific 
   cache directory if it is different from the default.   
   - git projects
   - ProjectTemplate projects
   - R packages
 
 - Tests 
 
 - Should a .Rprofile be created and added to the project to setup the cache?
   - If it is an rstudio project?
 
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
       before writing. 

 - [ ] cache to memory using a cache environment
       this just does an assignment when the cache is a environment
       
 - [ ] cache:::store, cache:::restore for explicit calling
   How does packrat work it so that packrat::XDX works but XDX does not?
   Tested. It doesn't.

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

   

