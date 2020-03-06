#' Plotting images
#'
#' Documentation for the plot method of segmented images and gray images
#' @param obj       an object of class Table or THsegments or grayimage
#' @param k         number of clusters in obj
#' @param org_image original image to be segmented
#' @param b         number of bands in the original image
#' @param ...       graphical parameters to imageplot
#' @param col       colurs to use for each class
#'
#' @import stars
#' @importFrom sf "sf.colors"
#' @importFrom graphics "plot"
#'
#' @examples
#' \dontrun{
#' library(stars)
#' tif <- read_stars(system.file("extdata/image.tif", package="ImageSegmentation"))
#' p <- seg_kmeans(tif,3,5)
#' imageplot(p,5,tif,3)
#'
#' e <- RGBtoGRAY(tif)
#' s <- segmentation_threshold(e)
#' imageplot(s)
#'
#' h <- RGBtoGRAY(tif)
#' imageplot(h)
#'
#' }
#'
#'
#'@export
imageplot <- function(obj, ...,k=NULL, org_image=NULL, b=NULL, col= NULL ) {
  UseMethod("imageplot")
}

#' @name imageplot
#' @export
imageplot.Table <- function(obj, k=NULL, org_image=NULL, b=NULL,...) {

  obj_matrix <- matrix(obj$cluster, nrow = dim(org_image)[1], ncol = dim(org_image)[2])

    s <- split(org_image,b)
    for (i in 1:dim(s[1])[1]){
          for (j in 1:dim(s[1])[2]){

            s[["X1"]][i,j]= obj_matrix[i,j]

          }

    }

    plot(s[1], col = sf.colors(k), main = NULL)

}

#' @name imageplot
#' @export
imageplot.THsegments <- function(obj, ..., col = sf.colors(4)) {
  plot(obj, ..., col = col , main = NULL)
}

#' @name imageplot
#' @export
imageplot.grayimage <- function(obj, ...) {
  plot(obj, ..., main = NULL)
}



