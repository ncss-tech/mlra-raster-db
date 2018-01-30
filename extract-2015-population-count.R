library(raster)
library(rgdal)
library(sp)

# current batch of 800m PRISM data
r <- raster('E:/gis_data/NASA-2015-population-density/gpw_v4_population_count_rev10_2015_30_sec.tif')
names(r) <- c('pop2015')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')

# extract: 1.5 minutes
system.time(e <- extract(r, s))

# save for later
save(e, file='E:/gis_data/MLRA/rda/pop2015-samples.rda')

rm(s, e, r)
gc()
