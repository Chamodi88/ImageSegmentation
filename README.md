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
                              
The function is demostrated in following steps using the image.tif file, which is a small portion of an aerial photo taken by SONY Alpha 5100 camera with 30m resolution.
             
              # Load the package
              library(ImageSegmentation)

              # Load stars package to read data
              library(stars)
              #> Loading required package: abind
              #> Loading required package: sf
              #> Linking to GEOS 3.6.1, GDAL 2.2.3, PROJ 4.9.3

              # Load the data from system files
              imgRGB <- read_stars(system.file("extdata/image.tif", package="ImageSegmentation"))

              # Convert colour image to grayscale
              grayimage <- RGBtoGRAY(imgRGB,n=3,Red=1,Green=2,Blue=3)
              grayimage
              #> stars object with 2 dimensions and 1 attribute
              #> attribute(s):
              #>       X1         
              #>  Min.   : 14.18  
              #>  1st Qu.: 83.81  
              #>  Median :123.52  
              #>  Mean   :116.04  
              #>  3rd Qu.:138.34  
              #>  Max.   :255.00  
              #> dimension(s):
              #>   from   to  offset delta                       refsys point values    
              #> x    1 1020  401951  0.03 +proj=utm +zone=32 +datum... FALSE   NULL [x]
              #> y    1  633 5755833 -0.03 +proj=utm +zone=32 +datum... FALSE   NULL [y]
      

## 2. Segmentation using thresholds
The fucntion segmentation_threshold can be used to segment an image of having single band. It takes an image of class “grayimage” as input and returns an image of class “THsegments”. It is designed to divide the pixel values into four clusters by user defined three thresholds.By defaults, the function utilizes mean of all pixels to defined three thresholds mean, half of mean and quarter of mean.

              # Segmenting a grayscale image
              segthresh <- segmentation_threshold(grayimage)
              segthresh
              #> stars object with 2 dimensions and 1 attribute
              #> attribute(s):
              #>       X1        
              #>  Min.   :1.000  
              #>  1st Qu.:3.000  
              #>  Median :4.000  
              #>  Mean   :3.463  
              #>  3rd Qu.:4.000  
              #>  Max.   :4.000  
              #> dimension(s):
              #>   from   to  offset delta                       refsys point values    
              #> x    1 1020  401951  0.03 +proj=utm +zone=32 +datum... FALSE   NULL [x]
              #> y    1  633 5755833 -0.03 +proj=utm +zone=32 +datum... FALSE   NULL [y]

## 3. Segmentation using kmeans algorithm
The fucntion seg_kmeans can be used to segment an image with three or more number of bands into desired number of segments. This function always returns an object of class “Table” resulting a table. The band values (i.e. red, green, blue etc.) of the original image are introduced to kmeans function from package stat to group them into clusters.

              # Segmenting an colour image into 5 clusters
              segkmeans <- seg_kmeans(imgRGB, b=3, k=5)

              # Displaying only first four rows of the table
              head(segkmeans, 4)
              #>          x       y cluster
              #> 1 401951.0 5755833       2
              #> 2 401951.1 5755833       2
              #> 3 401951.1 5755833       2
              #> 4 401951.1 5755833       2

## 4. Plotting segmented images and grayscale images
The plot method imageplot can be used to visualize the segmented images and also grayscale image. The method can be applied for object of classes “grayimage”, “THsegments” and “Table”. The methods utilizes plot.stars method inside to plot the images. Particularly, the plot method imageplot.Table converts a dataframe to an image.

              # Plotting a grayscale image
              imageplot(grayimage) 
   <p align="center">
   <img float="center" src="/vignettes/ImageSegmentation_files/figure-html/step4-1.png" width=300>
   </p>

              # Plotting an image segmented by thresholds
              imageplot(segthresh)
   <p align="center">
   <img float="center" src="/vignettes/ImageSegmentation_files/figure-html/step4-2.png" width=300>
   </p>
   
              # Plotting an image segmented by kmeans
              imageplot(segkmeans,k=5, org_image=imgRGB, b=3)
   <p align="center">
   <img float="center" src="/vignettes/ImageSegmentation_files/figure-html/step4-3.png" width=300>
   </p>

## 5. Extracting single class/cluster from segmented images
The method extract can be used to plot single class from segmented image for further analyzing them. The method can be applied for object of class “Table” and “THsegments”. The result is an binary image containing the selected class.

              # Extracting class 3 from an image segmented by thresholds
              extract(segthresh, cluster= 3)
   <p align="center">
   <img float="center" src="/vignettes/ImageSegmentation_files/figure-html/step5-1.png" width=300>
   </p>
     
              # Extracting class 2 from an image segmented by kmeans
              extract(segkmeans,cluster=2,org_image = imgRGB,b=3)
   <p align="center">
   <img float="center" src="/vignettes/ImageSegmentation_files/figure-html/step5-2.png" width=300>
   </p>
