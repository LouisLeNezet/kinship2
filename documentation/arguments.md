# List of all arguments to inherit

missid
dadid
id
momid
dadx
momx
idx
packed

# List of returned values
n
nid
pos
spouselist

# Roxygen S4 methods writing

```{r}
#' My function
#'
#' @param obj An object either a character vector or a pedigree
#' @param ... Arguments to be passed to methods
#'
#' @docType methods
#' @export
setGeneric("myfunction", signature = "obj",
    function(obj, ...) standardGeneric("myfunction")
)

#' @docType methods
#' @aliases myfunction,character
#' @rdname myfunction
#' @param dadid A character vector
#' @param momid A character vector
#' @param missid Character defining the missing ids
#' @usage ## S4 method for signature 'character'
#' @usage myfunction(dadid, momid, missid = "0")
#' @return A character vector with the parents ids
setMethod("myfunction", "character", function(dadid, momid, missid = "0") {
    paste(dadid, momid, sep = missid)
})

#' @docType methods
#' @aliases myfunction,Pedigree
#' @param ped A pedigree object
#' @param missid Character defining the missing ids
#' @usage ## S4 method for signature 'Pedigree'
#' @usage myfunction(dadid, momid, missid = "0")
#' @return A pedigree with the parents ids
setMethod("myfunction", "Pedigree",
    function(ped, missid = "0") {
        ped$par <- myfunction(ped$dadid, ped$momid, missid)
        ped
    }
)
```