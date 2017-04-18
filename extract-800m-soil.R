library(raster)
library(rgdal)
library(sp)

# current batch of 800m SoilWeb SSURGO-STATSGO properties
rs <- stack('E:/gis_data/800m-SoilWeb-grids-SSURGO-STATSGO/cec_025.tif', 
            'E:/gis_data/800m-SoilWeb-grids-SSURGO-STATSGO/paws_025.tif', 
            'E:/gis_data/800m-SoilWeb-grids-SSURGO-STATSGO/ph_025.tif'
            )
names(rs) <- c('CEC_025','PAWS_025','pH_025')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')

# extract: 10 seconds
system.time(e <- extract(rs, s))

# set better names
dimnames(e)[[2]] <- c('CEC at pH 7: 0-25cm', 'Plant Available Water Storage (cm): 0-25cm', 'pH: 0-25cm')

# save for later
save(e, file='E:/gis_data/MLRA/rda/soil-properties-samples.rda')

rm(s, e, rs)
gc()

