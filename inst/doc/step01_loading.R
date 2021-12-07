## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  fig.align = "center",
  fig.width = 6,
  strip.white = TRUE
)

## ---- echo=F------------------------------------------------------------------
library(recolorize)
current_par <- graphics::par(no.readonly = TRUE)

## ----setup--------------------------------------------------------------------
library(recolorize)

# define image path - we're using an image that comes with the package
img_path <- system.file("extdata/corbetti.png", package = "recolorize")

# load image
img <- readImage(img_path, resize = NULL, rotate = NULL)

# it's just an array with 4 channels:
dim(img)

## -----------------------------------------------------------------------------
layout(matrix(1:5, nrow = 1))
par(mar = c(0, 0, 2, 0))
plotImageArray(img, main = "RGB image")
plotImageArray(img[ , , 1], main = "R channel")
plotImageArray(img[ , , 2], main = "G channel")
plotImageArray(img[ , , 3], main = "B channel")
plotImageArray(img[ , , 4], main = "Alpha channel")

## -----------------------------------------------------------------------------
blurred_img <- blurImage(img, blur_function = "blur_anisotropic",
                         amplitude = 10, sharpness = 0.2)

## ---- echo=F------------------------------------------------------------------
graphics::par(current_par)

