library(terra)

# current batch of 800m SoilWeb SSURGO-STATSGO properties
rs <- c('E:/gis_data/FY2023-800m-rasters/rasters/cec_025.tif', 
            'E:/gis_data/FY2023-800m-rasters/rasters/paws_025.tif', 
            'E:/gis_data/FY2023-800m-rasters/rasters/ph_025.tif'
            )
names(rs) <- c('CEC_025','PAWS_025','pH_025')

rs <- lapply(rs, rast)
rs <- rast(rs)

# pre-made sampling points AEA
# spatVector
s <- readRDS('E:/gis_data/MLRA/rda/samples.rds')

# extract: 
# ~ 10 seconds | 2021, WD
# ~ 3.7 seconds | 2023, exclusions
system.time(e <- extract(rs, s, ID = FALSE))

# set better names
names(e) <- c('CEC at pH 7: 0-25cm', 'Plant Available Water Storage (cm): 0-25cm', 'pH: 0-25cm')

# save for later
saveRDS(e, file = 'E:/gis_data/MLRA/rda/soil-properties-samples.rds')

rm(s, e, rs)
gc(reset = TRUE)

