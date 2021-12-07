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

## -----------------------------------------------------------------------------
library(recolorize)
corbetti <- system.file("extdata/corbetti.png", package = "recolorize")
init_fit <- recolorize(corbetti, plotting = FALSE)
recluster_results <- recluster(init_fit, 
                               cutoff = 45)

## -----------------------------------------------------------------------------
recluster_rgb <- recluster(init_fit, color_space = "sRGB",
                           cutoff = 0.5)

## ---- fig.width = 5-----------------------------------------------------------
# let's use a different image:
img <- system.file("extdata/chongi.png", package = "recolorize")

# this is identical to running:
# fit1 <- recolorize(img, bins = 3)
# fit2 <- recluster(fit1, cutoff = 50)
chongi_fit <- recolorize2(img, bins = 3, cutoff = 45)

## ---- fig.width=5-------------------------------------------------------------
chongi_threshold <- thresholdRecolor(chongi_fit, pct = 0.1)

## ---- echo=F------------------------------------------------------------------
graphics::par(current_par)

