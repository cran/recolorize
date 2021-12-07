## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  fig.align = "center",
  fig.width = 4,
  strip.white = TRUE
)

## ---- echo=F------------------------------------------------------------------
library(recolorize)
current_par <- graphics::par(no.readonly = TRUE)

## ---- fig.width = 5, fig.height=4---------------------------------------------
library(recolorize)
img <- system.file("extdata/ephippigera.png", package = "recolorize")
rc <- recolorize2(img, plotting = FALSE)

layout(matrix(1:2, nrow = 1))
par(mar = c(0, 0, 2, 1))
# calculates the distance matrix and plots the results
dist_original <- imDist(readImage(img),
                        recoloredImage(rc), 
                        color_space = "sRGB", 
                        main = "Unscaled distances")

# more plotting options - setting the range is important for comparing 
# across images (max is sqrt(3) in sRGB space, ~120 in Lab)
imHeatmap(dist_original, range = c(0, sqrt(3)),
          main = "Scaled distances")

## ---- fig.width = 4, fig.height=3---------------------------------------------
hist(dist_original, main = "sRGB distances", xlab = "Distance")

## ---- fig.width = 5, fig.height=4.5-------------------------------------------
img <- system.file("extdata/corbetti.png", package = "recolorize")
rc <- recolorize2(img, cutoff = 45, plotting = FALSE)

layout(matrix(1:10, nrow = 2, byrow = TRUE))
par(mar = c(0, 0, 2, 0))
# 'overlay' is not always the clearest option, but it is usually the prettiest:
layers <- splitByColor(rc, plot_method = "overlay")

# layers is a list of matrices, which we can just plot:
for (i in 1:length(layers)) {
  plotImageArray(layers[[i]], main = i)
}

## ----eval=FALSE---------------------------------------------------------------
#  # export color map
#  recolorize_to_png(rc, filename = "corbetti_recolored.png")
#  
#  # export individual layers from splitByColor
#  for (i in 1:length(layers)) {
#    png::writePNG(layers[[i]],
#                  target = paste0("layer_", i, ".png"))
#  }

## ----eval=F-------------------------------------------------------------------
#  # convert to a classify object
#  as_classify <- classify_recolorize(rc, imgname = "corbetti")
#  adj_analysis <- pavo::adjacent(as_classify, xscale = 10)
#  
#  # run adjacent directly using human perceptual color distances (i.e. no spectral data - proceed with caution)
#  adj_human <- recolorize_adjacency(rc)

## ---- echo=F------------------------------------------------------------------
graphics::par(current_par)

