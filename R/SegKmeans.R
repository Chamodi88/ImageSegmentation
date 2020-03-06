#' Perform segmentation using kmeans algorithm on an image
#'
#' Documentation for the seg_kmeans function
#' @param im          Input image
#' @param b           Number of bands in the image (default is 3)
#' @param k           Number of clusters (default is 5)
#'
#'
#' @import stars
#' @importFrom stats kmeans
#'
#' @examples
#' \dontrun{
#' library(stars)
#' tif <- read_stars(system.file("extdata/image.tif", package="ImageSegmentation"))
#' j <- seg_kmeans(tif)
#' }
#'
#' @export
seg_kmeans = function(im, b=3, k=5){
  s <- split(im,b)
  df <- as.data.frame(s, wide="X")
  k <- kmeans(df,k)
  t <- cbind(df, cluster = k$cluster)
  keeps <- c("x", "y", "cluster")
  h <- t[keeps]
  class(h) <- c("Table", class(df))
  return(h)

}


