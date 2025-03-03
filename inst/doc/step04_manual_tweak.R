## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  dpi = 60,
  collapse = TRUE,
  comment = "#>", 
  fig.align = "center",
  fig.width = 4,
  strip.white = TRUE
)

## ----echo=F-------------------------------------------------------------------
library(recolorize)
current_par <- graphics::par(no.readonly = TRUE)

## -----------------------------------------------------------------------------
library(recolorize)
img <- system.file("extdata/fulgidissima.png", package = "recolorize")
ful_init <- recolorize2(img, bins = 3, cutoff = 60, plotting = TRUE)

## ----fig.width=5--------------------------------------------------------------
ful_absorb <- absorbLayer(ful_init, layer_idx = 3, 
                          function(s) s <= 250,
                          y_range = c(0, 0.8))

## ----fig.width = 4------------------------------------------------------------
# cleans up some of the speckles in the above output
ful_clean <- editLayers(ful_init, layer_idx = c(2, 5),
                        operations = "fill", px_sizes = 3, plotting = T)

## ----fig.width=5--------------------------------------------------------------
corbetti <- system.file("extdata/corbetti.png", package = "recolorize")
rc <- recolorize(corbetti, plotting = FALSE)
merge_fit <- mergeLayers(rc, 
                         merge_list = list(1, 2, 
                                           c(3, 5),
                                           c(4, 7),
                                           c(6, 8)))

## ----echo=F-------------------------------------------------------------------
graphics::par(current_par)

