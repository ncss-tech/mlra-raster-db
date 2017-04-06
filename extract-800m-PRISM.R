library(raster)
library(rgdal)
library(sp)

# current batch of 800m PRISM data
rs <- stack('E:/gis_data/PRISM_us_dem_800m.tif', 
            'E:/gis_data/prism/effective_precipitation_800m.tif', 
            'E:/gis_data/prism/ffd_mean_800m.tif',
            'E:/gis_data/prism/final_MAAT_800m.tif',
            'E:/gis_data/prism/final_MAP_mm_800m.tif',
            'E:/gis_data/prism/gdd_mean_800m.tif',
            'E:/gis_data/prism/rain_fraction_mean_800m.tif'
            )
names(rs) <- c('prism_elev','eff.ppt','ffd','maat','map','gdd','rain.fraction')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')

# extract: 26 seconds
system.time(e <- extract(rs, s))

# set better names
dimnames(e)[[2]] <- c('Elevation (m)', 'Effective Precipitation (mm)', 'Frost-Free Days', 'Mean Annual Air Temperature (degrees C)', 'Mean Annual Precipitation (mm)', 'Growing Degree Days (degrees C)', 'Fraction of Annual PPT as Rain')

# save for later
save(e, file='E:/gis_data/MLRA/rda/prism-samples.rda')

rm(s, e, rs)
gc()

