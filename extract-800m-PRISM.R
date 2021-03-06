library(raster)
library(rgdal)
library(sp)

# current batch of 800m PRISM data
rs <- stack('E:/gis_data/prism/PRISM_us_dem_800m.tif', 
            'E:/gis_data/prism/effective_precipitation_800m.tif', 
            'E:/gis_data/prism/ffd_50_pct_800m.tif',
            'E:/gis_data/prism/final_MAAT_800m.tif',
            'E:/gis_data/prism/final_MAP_mm_800m.tif',
            'E:/gis_data/prism/gdd_mean_800m.tif',
            'E:/gis_data/prism/rain_fraction_mean_800m.tif',
            'E:/gis_data/prism/q90_freeze_index_800m.tif'
            )
names(rs) <- c('prism_elev','eff.ppt','ffd','maat','map','gdd','rain.fraction', 'dfi_c')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')


# ~ 8 seconds | 2021, WD
system.time(rs <- readAll(rs))

# extract
# ~ 1.97 seconds | 2021, WD
system.time(e <- extract(rs, s))

# set better names
dimnames(e)[[2]] <- c('Elevation (m)', 'Effective Precipitation (mm)', 'Frost-Free Days', 'Mean Annual Air Temperature (degrees C)', 'Mean Annual Precipitation (mm)', 'Growing Degree Days (degrees C)', 'Fraction of Annual PPT as Rain', 'Design Freeze Index (degrees C)')

# save for later
save(e, file='E:/gis_data/MLRA/rda/prism-samples.rda')

rm(s, e, rs)
gc(reset = TRUE)

