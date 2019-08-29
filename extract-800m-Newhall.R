library(raster)
library(rgdal)
library(sp)

# current batch of 800m PRISM data
rs <- stack('E:/gis_data/Newhall/results/bio5dryCum.tif', 
            'E:/gis_data/Newhall/results/bio5mstCum.tif', 
            'E:/gis_data/Newhall/results/bio8mstCon.tif',
            'E:/gis_data/Newhall/results/smrdryCons.tif',
            'E:/gis_data/Newhall/results/yrdryCum.tif'
)
names(rs) <- c('prism_elev','eff.ppt','ffd','maat','map','gdd','rain.fraction', 'dfi_c')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')


# ~ 9 seconds no AMP
# ~ 9 seconds with AMP + process-exclusions
system.time(rs <- readAll(rs))

# extract
# ~ 22 seconds from disk no AMP
# ~ 22 seconds from disk with AMP + process-exclusions
# ~ 1.3 seconds from RAM no AMP
# ~ 1.3 seconds from RAM with AMP + process-exclusions
system.time(e <- extract(rs, s))

# set better names
dimnames(e)[[2]] <- c('Elevation (m)', 'Effective Precipitation (mm)', 'Frost-Free Days', 'Mean Annual Air Temperature (degrees C)', 'Mean Annual Precipitation (mm)', 'Growing Degree Days (degrees C)', 'Fraction of Annual PPT as Rain', 'Design Freeze Index (degrees C)')

# save for later
save(e, file='E:/gis_data/MLRA/rda/prism-samples.rda')

rm(s, e, rs)
gc(reset = TRUE)

