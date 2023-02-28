library(sharpshootR)
library(terra)

mlra <- vect('E:/gis_data/MLRA/MLRA_52-conus.shp')

# unique ID for sampling
mlra$pID <- 1:nrow(mlra)

# transform to CONUS AEA (EPSG: 5070) 
mlra <- project(mlra, 'EPSG:5070')

# sample all CONUS polygons
# ~ 7.9 minutes | 2021, WD
# ~ 1 minute | 2023, VPN
system.time(s <- constantDensitySampling(mlra, n.pts.per.ac = 0.0005))
nrow(s)

# rename
s$mlra <- s$MLRARSYM
s$MLRARSYM <- NULL

saveRDS(s, file = 'E:/gis_data/MLRA/rda/samples.rds')

rm(mlra, s)
gc(reset = TRUE)

## TODO:

# HI / Pacific Islands

# AK

# PR


