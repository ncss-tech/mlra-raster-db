library(raster)
library(rgdal)
library(sp)

# current batch of 800m PRISM data
r <- raster('E:/gis_data/NLCD/nlcd_2011_landcover_2011_edition_2014_03_31.img')
names(r) <- c('nlcd')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')

## not possible: file is too large
# system.time(r <- readAll(r))

# extract: 
# ~ 14 minutes windows 7
# ~ 20 minutes from disk with AMP + process-exclusions
system.time(e <- extract(r, s))

# save for later
save(e, file='E:/gis_data/MLRA/rda/nlcd-samples.rda')

rm(s, e, r)
gc()

