## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(dpi = 60,
  collapse = TRUE,
  comment = "#>", 
  fig.align = "center",
  fig.width = 4,
  strip.white = TRUE
)

## ----setup, echo=F------------------------------------------------------------
par(mar = rep(0, 4))

## ----echo = FALSE, fig.width=6, fig.height=3.5--------------------------------
library(recolorize)
current_par <- graphics::par(no.readonly = TRUE)
img <- system.file("extdata/corbetti.png", package = "recolorize")
rc <- suppressMessages(recolorize2(img,
                                  cutoff = 45, plotting = FALSE))
v <- system.file("extdata/msc/corbetti_vector.rds", package = "recolorize")
v <- readRDS(v)
layout(matrix(1:4, nrow = 1), widths = c(0.3, 0.3, 0.3, 0.1))
par(mar = c(1, 1, 3, 1))
plotImageArray(readImage(img))
title("Original    ", line = 1, font.main = 1, cex.main = 1.2)
plotImageArray(recoloredImage(rc))
title("Color map (bitmap)    ", line = 1, font.main = 1, cex.main = 1.2)
par(mar = c(1, 1, 3, 1))
# plot(v)
title("Color map (vector)", font.main = 1, cex.main = 1.2)
plotColorPalette(rc$centers, rc$sizes, horiz = F)
rm(v, rc)

## ----eval=F-------------------------------------------------------------------
# library(recolorize)
# 
# # get the path to the image (comes with the package, so we use system.file):
# img <- system.file("extdata/corbetti.png", package = "recolorize")
# 
# # fit a color map (only provided parameter is a color similarity cutoff)
# recolorize_obj <- recolorize2(img, cutoff = 45)

## ----fig.width=4--------------------------------------------------------------
library(recolorize)
init_fit <- recolorize(img, method = "hist", bins = 2, 
                       color_space = "sRGB")

## ----fig.width=4--------------------------------------------------------------
refined_fit <- recluster(init_fit, cutoff = 45)

## ----fig.width = 4------------------------------------------------------------
final_fit <- editLayer(refined_fit, 3,
                        operation = "fill", px_size = 4)

## -----------------------------------------------------------------------------
adj <- recolorize_adjacency(final_fit, coldist = "default", hsl = "default")
print(adj[ , grep("m_dL|m_dS", colnames(adj))]) # just print the chromatic and achromatic boundary strength values

## -----------------------------------------------------------------------------
# get all 5 beetle images:
images <- dir(system.file("extdata", package = "recolorize"), "png", full.names = TRUE)

# make an empty list to store the results:
rc_list <- vector("list", length = length(images))

# run `recolorize2` on each image
# you would probably want to add more sophisticated steps in here as well, but you get the idea
for (i in 1:length(images)) {
  rc_list[[i]] <- suppressMessages(recolorize2(images[i], bins = 2, 
                              cutoff = 30, plotting = FALSE))
}

# plot for comparison:
layout(matrix(1:10, nrow = 2))
par(mar = rep(0, 4))
for (i in rc_list) {
  plotImageArray(i$original_img)
  plotImageArray(recoloredImage(i))
}

# given the variety of colors in the dataset, not too bad, 
# although you might go in and refine these individually

# and clean up our working space a bit
rm(rc_list)

## -----------------------------------------------------------------------------
attributes(final_fit)

## -----------------------------------------------------------------------------
final_fit$call

## ----fig.width = 2------------------------------------------------------------
# type = raster gets you a raster (like original_img); type = array gets you an 
# image array
recolored_img <- recoloredImage(final_fit, type = "array")
par(mar = rep(0, 4))
plotImageArray(recolored_img)

## ----fig.width = 2------------------------------------------------------------
colors <- c("navy", "lightblue", "blueviolet",
            "turquoise", "slateblue", "royalblue", 
            "aquamarine", "dodgerblue")
blue_beetle <- constructImage(final_fit$pixel_assignments, 
               centers = t(col2rgb(colors) / 255))

# a very blue beetle indeed:
par(mar = rep(0, 4))
plotImageArray(blue_beetle)

## ----echo=F-------------------------------------------------------------------
graphics::par(current_par)

