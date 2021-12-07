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
par(mar = c(0, 0, 2, 0))

## ---- echo=F,fig.with = 5,message=F,fig.align='center'------------------------
library(recolorize)
ful <- readImage(system.file("extdata/fulgidissima.png", package = "recolorize"))
ful_blur <- blurImage(ful, "blur_anisotropic", amplitude = 10, sharpness = 0.5, plotting = FALSE)

# 2 color
ful1 <- suppressMessages(recolorize2(ful_blur, bins = 3, cutoff = 100, 
                    color_space = "Lab", plotting = FALSE))
ful2 <- absorbLayer(ful1, 2, function(s) s <= 300, plotting=F)

# 5 color
ful3 <- recolorize2(ful_blur, bins = 3, cutoff = 60, color_space = "sRGB", plotting = F)

layout(matrix(1:3, nrow = 1))
par(mar = c(0, 0, 2, 0))
plotImageArray(raster_to_array(ful1$original_img))
title(main = "original    ", font.main = 1)
plotImageArray(recoloredImage(ful2))
title(main = "map 1    ", font.main = 1)
plotImageArray(recoloredImage(ful3))
title(main="map 2    ", font.main = 1)

## ---- echo=F------------------------------------------------------------------
graphics::par(current_par)

