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

## ----setup--------------------------------------------------------------------
library(recolorize)

# get path to image
corbetti <- system.file("extdata/corbetti.png", package = "recolorize")

# cluster using defaults
recolorize_defaults <- recolorize(img = corbetti)

## ---- fig.width=6, fig.height=2.5, echo=F, message=F--------------------------
img <- readImage(corbetti)
pix <- backgroundIndex(img, 
                       bg_condition = backgroundCondition(transparent = TRUE,
                                                          alpha_channel = TRUE,
                                                          quietly = TRUE))
pix <- pix$non_bg[sample(1:nrow(pix$non_bg), 5000), ]

plot_colors <- function(rgb_matrix, color_space = "sRGB",
                        theta = 140, phi = 30, pch = 19, alpha = 0.5, 
                        ...) {
  
  hex_colors <- rgb(r = rgb_matrix[ , 1], 
                    g = rgb_matrix[ , 2], 
                    b =  rgb_matrix[ , 3])
  
  pix <- recolorize:::col2col(rgb_matrix, from = "sRGB", to = color_space)
  
  plot3D::points3D(pix[,1], pix[,2], pix[,3],
                   colvar = as.numeric(as.factor(hex_colors)),
                   col = levels(as.factor(hex_colors)), colkey = FALSE,
                   theta = theta, phi = phi, pch = pch,
                   alpha = alpha,
                   ...)
}

th <- 60
layout(matrix(1:2, nrow = 1))
par(mar = rep(1, 4))
plot_colors(pix, color_space = "sRGB",
            xlab = "Red",
            ylab = "Green",
            zlab = "Blue", theta = th, 
            alpha = 0.8)
title("RGB color space", line = 0)
plot_colors(pix, color_space = "sRGB",
            xlab = "Red",
            ylab = "Green",
            zlab = "Blue", 
            alpha = 0.8, 
            theta = th + 180)
plot_colors(pix, color_space = "Lab",
            xlab = "Luminance",
            ylab = "a (red-green)",
            zlab = "b (yellow-blue)", 
            alpha = 0.8, theta = th)
title("CIE Lab color space", line = 0)
plot_colors(pix, color_space = "Lab",
            xlab = "Luminance",
            ylab = "a (red-green)",
            zlab = "b (yellow-blue)", 
            alpha = 0.8, theta = th + 180)

## ---- fig.width = 3.5, fig.height=3.5-----------------------------------------
# fit 64 colors, both ways
r_hist <- recolorize(corbetti, method = "hist", bins = 3, plotting = FALSE)
r_k <- recolorize(corbetti, method = "k", n = 37, plotting = FALSE)

par(mar = rep(1, 4))
plotColorClusters(r_hist$centers, r_hist$sizes, scaling = 30,
                  plus = .05,
                  xlab = "red", ylab = "green", zlab = "blue", 
                  main = "Histogram method",
                  xlim = 0:1, ylim = 0:1, zlim = 0:1)
plotColorClusters(r_k$centers, r_k$sizes, scaling = 30,
                  plus = .05,
                  xlab = "red", ylab = "green", zlab = "blue",
                  main = "k-means clustering",
                  xlim = 0:1, ylim = 0:1, zlim = 0:1)

## ---- fig.height=3------------------------------------------------------------
k_list <- lapply(1:3, function(i) recolorize(corbetti, "k", n = 10, plotting = F))

layout(1:3)
par(mar = rep(1, 4))
plotColorPalette(k_list[[1]]$centers, k_list[[1]]$sizes)
plotColorPalette(k_list[[2]]$centers, k_list[[2]]$sizes)
plotColorPalette(k_list[[3]]$centers, k_list[[3]]$sizes)

## ---- fig.width = 4-----------------------------------------------------------
# we can go from an unacceptable to an acceptable color map in 
# CIE Lab space by adding a single additional bin in the luminance channel:
r_hist_2 <- recolorize(corbetti, method = "hist", color_space = "Lab", 
                     bins = 2)
r_hist_322 <- recolorize(corbetti, 
                     method = "hist",
                     bins = c(3, 2, 2))


## ---- fig.width = 4-----------------------------------------------------------
im1 <- system.file("extdata/ocellata.png", package = "recolorize")
im2 <- system.file("extdata/ephippigera.png", package = "recolorize")

# fit the first image
fit1 <- recolorize(im1)

# fit the second image using colors from the first
# adjust_centers = TRUE would find the average color of all the pixels assigned to 
# the imposed colors to better match the raw image
fit2 <- imposeColors(im2, fit1$centers, adjust_centers = FALSE)

## ---- echo=F------------------------------------------------------------------
graphics::par(current_par)

