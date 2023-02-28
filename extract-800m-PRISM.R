library(terra)

# current batch of 800m PRISM data
rs <- c('E:/gis_data/prism/PRISM_us_dem_800m.tif', 
            'E:/gis_data/prism/effective_precipitation_800m.tif', 
            'E:/gis_data/prism/ffd_50_pct_800m.tif',
            'E:/gis_data/prism/final_MAAT_800m.tif',
            'E:/gis_data/prism/final_MAP_mm_800m.tif',
            'E:/gis_data/prism/gdd_mean_800m.tif',
            'E:/gis_data/prism/rain_fraction_mean_800m.tif',
            'E:/gis_data/prism/q90_freeze_index_800m.tif'
            )

rs <- lapply(rs, rast)
rs <- rast(rs)

names(rs) <- c('prism_elev','eff.ppt','ffd','maat','map','gdd','rain.fraction', 'dfi_c')

# pre-made sampling points AEA
# spatVector
s <- readRDS('E:/gis_data/MLRA/rda/samples.rds')

# back to GCS NAD83
s <- project(s, 'EPSG:4296')

# extract
# ~ 1.97 seconds | 2021, WD
# ~ 1.5 seconds | 2023
system.time(e <- extract(rs, s))

# set better names
names(e)<- c('Elevation (m)', 'Effective Precipitation (mm)', 'Frost-Free Days', 'Mean Annual Air Temperature (degrees C)', 'Mean Annual Precipitation (mm)', 'Growing Degree Days (degrees C)', 'Fraction of Annual PPT as Rain', 'Design Freeze Index (degrees C)')

# save for later
saveRDS(e, file = 'E:/gis_data/MLRA/rda/prism-samples.rds')

rm(s, e, rs)
gc(reset = TRUE)

