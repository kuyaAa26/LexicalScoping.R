

makeCacheMatrix <- function(v = matrix()) 
{
        # stores the cached value
        # initialize to NULL
        cache <- NULL

        # create the matrix in the working environment
        set <- function(z) 
	{
                v <<- z
                cache <<- NULL
        }

        # get the value of the matrix
        get <- function() v
        # invert the matrix and store in cache
        setMatrix <- function(inverse) cache <<- inverse
        # get the inverted matrix from cache
        getInverse <- function() cache

        # return the created functions to the working environment
        list(set = set, get = get,
             setMatrix = setMatrix,
             getInverse = getInverse)
}



#cache Solve Function below

cacheSolve <- function(v, ...) {
        ## get the inverse of the matrix stored in cache
        cache <- v$getInverse()

        # return inverted matrix from cache if it exists
        # else create the matrix in working environment
        if (!is.null(cache)) {
                message("getting cached data")

                # display matrix in console
                return(cache)
        }

        # create matrix since it does not exist
        matrix <- v$get()

        # make sure matrix is square and invertible
        # if not, handle exception cleanly
        tryCatch( {
                # set and return inverse of matrix
                cache <- solve(matrix, ...)
        },
        error = function(e) {
                message("Error:")
                message(e)

                return(NA)
        },
        warning = function(e) {
                message("Warning:")
                message(e)

                return(NA)
        },
        finally = {
                # set inverted matrix in cache
                v$setMatrix(cache)
        } )

        # returns the matrix
        return (cache)
}