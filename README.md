# cache 

The **cache** package is designed to make saving and restoring R objects 
consistent and easy. The cache exists on a per-project basis. Together with the 
**-tk** package. Those data sets can be saved and easily refreshed.

## Installation 

    install_github( "decisionpatterns/cache" )


## Usage 

    cache(object)    # save object to cache
    cache("object")  # same (by name)
     
    uncache(object)
    uncache(object)
     
    use_cache()    # Creates a cache directory
    
##    
