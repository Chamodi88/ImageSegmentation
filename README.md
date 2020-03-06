# ImageSegmentation
***R package to perform image segmentation***\
***Chamodi Boyagoda***\
***2019-08-07***
## Introduction
This will introduces and explains the use of the package ImageSegmentation which is written in R to perform segmentation based on pixel values of raster images including digital photos which are having at least three bands.This package basically uses functions of the package stars to read images, the package stats to run kmeans algorithm, the package sf for default colours and graphics to plot images. The package ImageSegmentation contains a method to convert colour image to gray image, two methods to segment images and two methods to visualize the results introducing three new classes. Following sections explain them in details:

1. Converting colour image to gray image
2. Segmentation using thresholds
3. Segmentation using kmeans algorithm
4. Plotting segmented images and grayscale images
5. Extracting single class/cluster from segmented image

## 1. Converting colour image to gray image
The fucntion RGBtoGRAY can be used to convert an image with three or more number of bands into single band image. This function always returns an object of class “grayimage”. The weighted sum of R, G and B values of the original image is computed to produce the new image with one band. Weights used in the formula are similar weights used to calculate Luma (y’) component. According to the formula, Red has contribute 29.9%, Green has contributed 58.7% and Blue has contributed 11.4%.

Formula used to produce grayscale image:

                              grayimage = 0.299 * R + 0.587 * G + 0.114 * B
                              
## 2. Segmentation using thresholds
The fucntion segmentation_threshold can be used to segment an image of having single band. It takes an image of class “grayimage” as input and returns an image of class “THsegments”. It is designed to divide the pixel values into four clusters by user defined three thresholds.By defaults, the function utilizes mean of all pixels to defined three thresholds mean, half of mean and quarter of mean.

## 3. Segmentation using kmeans algorithm
The fucntion seg_kmeans can be used to segment an image with three or more number of bands into desired number of segments. This function always returns an object of class “Table” resulting a table. The band values (i.e. red, green, blue etc.) of the original image are introduced to kmeans function from package stat to group them into clusters. 

## 4. Plotting segmented images and grayscale images
The plot method imageplot can be used to visualize the segmented images and also grayscale image. The method can be applied for object of classes “grayimage”, “THsegments” and “Table”. The methods utilizes plot.stars method inside to plot the images. Particularly, the plot method imageplot.Table converts a dataframe to an image.

## 5. Extracting single class/cluster from segmented images
The method extract can be used to plot single class from segmented image for further analyzing them. The method can be applied for object of class “Table” and “THsegments”. The result is an binary image containing the selected class.
