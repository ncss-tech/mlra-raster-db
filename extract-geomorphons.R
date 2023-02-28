library(terra)

# 30m geomorphons
r <- rast('E:/gis_data/CONUS/CONUS-forms-DEB.tif')
names(r) <- c('geomorphons')

# pre-made sampling points
# spatVect EPSG:5070
s <- readRDS('E:/gis_data/MLRA/rda/samples.rds')


# extract from disk
# ~ 11 minutes | 2021, WD, raster package
# ~ 20 seconds | 2021, WD, terra package
# ~ 19 seconds | 2022, WD exclusions in place, terra 
# ~ 15 seconds | 2023, VPN exclusions in place
# note that terra::extract() returns a data.frame
system.time(e <- extract(r, s)$geomorphons)

# save for later
saveRDS(e, file='E:/gis_data/MLRA/rda/geomorphons-samples.rds')

rm(s, e, r)
gc()
