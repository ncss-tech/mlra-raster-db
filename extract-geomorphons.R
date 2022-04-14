library(terra)
library(sf)
library(sp)

# 30m geomorphons
r <- rast('E:/gis_data/CONUS/CONUS-forms-DEB.tif')
names(r) <- c('geomorphons')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')

# convert SPDF -> terra::spatVect
s <- st_as_sf(s)
s <- vect(s)

# extract from disk
# ~ 11 minutes | 2021, WD, raster package
# ~ 20 seconds | 2021, WD, terra package
# ~ 19 seconds | 2022, WD exclusions in place, terra 
# note that terra::extract() returns a data.frame
system.time(e <- extract(r, s)$geomorphons)

# save for later
save(e, file='E:/gis_data/MLRA/rda/geomorphons-samples.rda')

rm(s, e, r)
gc()
