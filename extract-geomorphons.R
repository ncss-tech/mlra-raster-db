library(raster)
library(rgdal)
library(sp)

# 30m geomorphons
r <- raster('E:/gis_data/CONUS/CONUS-forms-DEB.tif')
names(r) <- c('geomorphons')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')

# extract from disk
# ~ 12 minutes (windows 7)
# ~ 20 minutes no AMP
system.time(e <- extract(r, s))

# save for later
save(e, file='E:/gis_data/MLRA/rda/geomorphons-samples.rda')

rm(s, e, r)
gc()
