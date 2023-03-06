library(terra)

# current batch of 800m PRISM data
r <- rast('E:/gis_data/NASA-2015-population-density/gpw_v4_population_count_rev10_2015_30_sec.tif')
names(r) <- c('pop2015')

# pre-made sampling points
# spatVect EPSG:5070
s <- readRDS('E:/gis_data/MLRA/rda/samples.rds')

# transform to CRS of population density
s <- project(s, crs(r))

# extract
# ~ 1.5 minutes (?)
# ~ 119 seconds from disk with AMP + process-exclusions
# ~ 2 seconds | 2023, exclusions in place
# note that terra::extract() returns a data.frame
system.time(e <- extract(r, s)$pop2015)

# save for later
saveRDS(e, file = 'E:/gis_data/MLRA/rda/pop2015-samples.rds')

rm(s, e, r)
gc(reset = TRUE)
