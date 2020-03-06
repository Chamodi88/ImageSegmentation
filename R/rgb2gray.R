#' converting RGB image to gray image
#'
#' Documentation for the RGBtoGRAY function
#' @param m       Input image
#' @param n       Number of bands in the image (default is 3)
#' @param Red     Band number of red (default is 1)
#' @param Green   Band number of green (default is 2)
#' @param Blue    Band number of blue (default is 3)
#'
#' @return an object of class "grayimage"
#'
#' @import stars
#'
#' @examples
#' \dontrun{
#' library(stars)
#' imgRGB <- read_stars(system.file("extdata/image.tif", package="ImageSegmentation"))
#' RGBtoGRAY(imgRGB,3,1,2,3)
#' }
#'
#' @export
RGBtoGRAY = function(m,n=3,Red=1,Green=2,Blue=3){

            split(m,n) -> img

              R <- img[Red]
              G <- img[Green]
              B <- img[Blue]

              gray_img = 0.299 * R + 0.587 * G + 0.114 * B

              class(gray_img) <- c("grayimage", class(gray_img))

              return(gray_img)

}


