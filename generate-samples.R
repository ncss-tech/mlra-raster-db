library(sharpshootR)
library(rgdal)

mlra <- readOGR(dsn='E:/gis_data/MLRA', layer='conus-mlra-v42', stringsAsFactors = FALSE)

# unique ID for sampling
mlra$pID <- 1:nrow(mlra)

# sample all CONUS polygons
system.time(s <- constantDensitySampling(mlra, n.pts.per.ac=0.0005))
nrow(s)

# extract MLRA code
s$mlra <- over(s, mlra)$MLRARSYM

save(s, file='E:/gis_data/MLRA/rda/samples.rda')

rm(mlra, s)
gc()

## TODO:

# HI

# AK

# PR


# Pac Basin?
