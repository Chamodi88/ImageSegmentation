#' extracting clusters
#'
#' Documentation for the extract method of single cluster/class from segmented images
#' @param segimg    an object of class Table or THsegments or grayimage
#' @param cluster   cluster number to be extracted
#' @param org_image original image to be segmented
#' @param b         number of bands in the original image
#' @param ...       graphical parameters to imageplot
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
#' extract(p,2,tif,3)
#'
#' e <- RGBtoGRAY(tif)
#' s <- segmentation_threshold(e)
#' extract(s, cluster=3)
#'
#' }
#'
#'
#'@export
extract <- function(segimg, ..., cluster=NULL, org_image=NULL, b=NULL) {
  UseMethod("extract")
}

#' @name extract
#' @export
extract.Table <- function(segimg, cluster= 1,org_image=NULL, b=NULL,...) {
  for (i in 1:length(segimg$cluster)){
      if (segimg$cluster[i] != cluster) {
        segimg$cluster[i] == 0
      }
      else segimg$cluster[i] == segimg$cluster[i]
      }

  segimg_matrix <- matrix(segimg$cluster, nrow = dim(org_image)[1], ncol = dim(org_image)[2])

  s <- split(org_image,b)
  for (i in 1:dim(s[1])[1]){
    for (j in 1:dim(s[1])[2]){

      s[["X1"]][i,j]= segimg_matrix[i,j]

    }

  }

  plot(s[1], col = sf.colors(2), main = NULL)

}

#' @name extract
#' @export
extract.THsegments <- function(segimg, ..., cluster= 1) {

  for (i in 1:dim(segimg)[1]){
    for (j in 1:dim(segimg)[2]){
      if (segimg[["X1"]][i,j] != cluster) {
            segimg[["X1"]][i,j] = 0
      }
      else segimg[["X1"]][i,j] = cluster

    }

  }


plot(segimg, col = sf.colors(2), main = NULL)
}
