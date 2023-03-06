library(terra)

# NLCD
r <- rast('E:/gis_data/NLCD/nlcd_2011_landcover_2011_edition_2014_03_31.img')
names(r) <- c('nlcd')

# pre-made sampling points
# spatVect EPSG:5070
s <- readRDS('E:/gis_data/MLRA/rda/samples.rds')

# transform to CRS of NLCD
s <- project(s, crs(r))

# extract: 
# ~ 14 minutes windows 7
# ~ 20 minutes from disk with AMP + process-exclusions
# ~ 2.2 minutes | 2023, exclusions in place
# note that terra::extract() returns a data.frame
system.time(e <- extract(r, s)$nlcd)

# save for later
saveRDS(e, file='E:/gis_data/MLRA/rda/nlcd-samples.rds')

rm(s, e, r)
gc(reset = TRUE)

