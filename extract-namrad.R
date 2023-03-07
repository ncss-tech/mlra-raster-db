library(terra)

# current batch of radiometric data
rs <- list('E:/gis_data/radiometric/namrad_exp_aea.tif', 
            'E:/gis_data/radiometric/namrad_k_aea.tif', 
            'E:/gis_data/radiometric/namrad_th_aea.tif',
            'E:/gis_data/radiometric/namrad_u_aea.tif')
names(rs) <- c('exp','K','Th','U')

rs <- lapply(rs, rast)
rs <- rast(rs)

# pre-made sampling points AEA
# spatVector
s <- readRDS('E:/gis_data/MLRA/rda/samples.rds')

# back to GCS NAD83
s <- project(s, crs(rs))

# extract:
# ~ 12 seconds | 2021, WD
# ~ 2 seconds | 2023, exclusions
system.time(e <- extract(rs, s, ID = FALSE))

# set better names
names(e) <- c('Exp', 'Potasium', 'Thorium', 'Uranium')

# save for later
saveRDS(e, file = 'E:/gis_data/MLRA/rda/namrad-samples.rds')

rm(s, e, rs)
gc(reset = TRUE)

