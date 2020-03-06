#' Perform segmentation on a gray image
#'
#' Documentation for the segmentation_threshold function
#' @param p           Input an object of class "grayimage"
#' @param val1        Threshold value 1 (default is mean of all pixel values)
#' @param val2        Threshold value 2 (default is half of mean)
#' @param val3        Threshold value 3 (default is one quarter of mean)
#'
#' @return returns an object of class "THsegments"
#'
#' @import stars
#'
#' @examples
#' \dontrun{
#' library(stars)
#' pic <- read_stars(system.file("extdata/image.tif", package="ImageSegmentation"))
#' g <- RGBtoGRAY(pic,3,1,2,3)
#' segmentation_threshold(g)
#' }
#'
#' @export
segmentation_threshold = function(p,val1=mean,val2= 0.5*mean,val3=0.25*mean){

  mean = mean(p[["X1"]])

  for (i in 1:dim(p)[1]){
    for (j in 1:dim(p)[2]){
      if (p[["X1"]][i,j] > val1){
        p[["X1"]][i,j]= 4
      }
      else if (p[["X1"]][i,j] > val2){
        p[["X1"]][i,j]= 3
      }
      else if (p[["X1"]][i,j] > val3){
        p[["X1"]][i,j]= 2
      }

      else{
        p[["X1"]][i,j] = 1
      }

    }

  }
  class(p) <- c("THsegments", class(p))
  return(p)
}


