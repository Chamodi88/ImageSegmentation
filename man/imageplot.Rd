% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/imageplot.R
\name{imageplot}
\alias{imageplot}
\alias{imageplot.Table}
\alias{imageplot.THsegments}
\alias{imageplot.grayimage}
\title{Plotting images}
\usage{
imageplot(obj, ..., k = NULL, org_image = NULL, b = NULL,
  col = NULL)

\method{imageplot}{Table}(obj, k = NULL, org_image = NULL, b = NULL,
  ...)

\method{imageplot}{THsegments}(obj, ..., col = sf.colors(4))

\method{imageplot}{grayimage}(obj, ...)
}
\arguments{
\item{obj}{an object of class Table or THsegments or grayimage}

\item{...}{graphical parameters to imageplot}

\item{k}{number of clusters in obj}

\item{org_image}{original image to be segmented}

\item{b}{number of bands in the original image}

\item{col}{colurs to use for each class}
}
\description{
Documentation for the plot method of segmented images and gray images
}
\examples{
\dontrun{
library(stars)
tif <- read_stars(system.file("extdata/image.tif", package="ImageSegmentation"))
p <- seg_kmeans(tif,3,5)
imageplot(p,5,tif,3)

e <- RGBtoGRAY(tif)
s <- segmentation_threshold(e)
imageplot(s)

h <- RGBtoGRAY(tif)
imageplot(h)

}


}
