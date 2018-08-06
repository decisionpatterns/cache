#' @title Cache objects using AES encryption
#'
#' @description
#' Caches objects with AES encryption using the *sodium* package
#'
#' @details
#'
#' Encrypts cached datasets using AES256 encryption provided by the *sodium*
#' package
#'
#' @examples
#'
#' dontrun{
#'  cache_use_aes()
#'  cache(mtcars)
#'  if( exists('mtcars') ) rm(mtcars)
#'  uncache(mtcars)
#'  fs::dir_ls( cache_find() )
#' }
#'
#' @export

cache_use_aes <- function()
  options( cache.write = cache_write_aes, cache.read = cache_read_aes )


#' @param object object to store.
#' @param name string; name of object
#' @param cache string; path to cache directory. Defaults to [cache_find()]
#' @param key string; encrypton key. Defaults to option cache.aes_key
#'
#' @details
#'
#' `cache_write_aes` and `cache_read_aes` are functions for
#' reading and writing AES encrypted objects to/from the cache. In most cases,
#' [cache()] and [uncache()] should be used with [cache_set_aes()] instead.
#'
#'
#' The extension given to AES encrypted files is `aesrds`.
#'
#' @return
#'   `object` (In order to be pipe-able, the object must be returned)
#'
#' @examples
#'   cache_write_aes( iris, "my key" )
#'   cache_read_aes( 'iris', "my key" )
#'
#' @importFrom sodium data_encrypt
#' @importFrom sodium data_decrypt
#' @rdname cache_use_aes
#' @export

cache_write_aes <- function(
    object
  , key = getOption( "cache.aes_key", set_option( cache.aes_key = readline("AES Encryption Key? ") ) )
  , ...
  , name = deparse( substitute(object) )
  , cache = cache_find()
) {

  if( ! require(sodium) ) stop( "The sodium is required for encrypting data sets.")

  object  ->.;
    aes_encrypt(., key) ->
    write_this

  path <- fs::path( cache, paste0( name, ".aesrds" ) )

  save_rds( write_this, path, ... )

  invisible(object)
}

#' @param name string; name of object in the cache
#' @param cache string; path to cache directory. Defaults to [cache_find()]
#'
#' @details
#'
#' `cache_read_aes` reads an AES encrypted object from the cache. `AES`
#' encrypted objects are
#'
#' @importFrom sodium data_decrypt
#' @importFrom fs path
#' @importFrom fs path_ext_set
#' @rdname cache_use_aes
#' @export

cache_read_aes <- function(
    name
  , key = getOption("cache.aes_key", set_option( cache.aes_key = readline("AES Encryption Key? ") ) )
  , cache = cache_find()
) {

  if( ! require(sodium) ) stop("The sodium is required for decrypting data sets.")

  path <- {
    cache ->.;
      fs::path( ., name ) ->.;
      fs::path_ext_set( ., aes_extension )
    }

  path  ->.;
    readRDS(.) ->.;
    aes_decrypt(., key)

}





# Utilities (Not exported)

aes_extension = 'aesrds'

make_aes_key <- function(key) {

  key  ->.;
   charToRaw(.) ->.;
   sha256(.)

}


aes_encrypt <- function(object,key) {

  if( ! require(sodium) ) stop( "The sodium is required for encrypting data sets.")

  object  ->.;
    serialize(., NULL)  ->.;
    data_encrypt(., make_aes_key(key) )

}

aes_decrypt <- function(object,key) {

  if( ! require(sodium) ) stop("The sodium is required for decrypting data sets.")

  object ->.;
    data_decrypt( ., make_aes_key(key) ) ->.;
    unserialize(.)

}
