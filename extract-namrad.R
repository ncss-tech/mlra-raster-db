library(raster)
library(rgdal)
library(sp)

# current batch of radiometric data
rs <- stack('E:/gis_data/radiometric/namrad_exp_aea.tif', 
            'E:/gis_data/radiometric/namrad_k_aea.tif', 
            'E:/gis_data/radiometric/namrad_th_aea.tif',
            'E:/gis_data/radiometric/namrad_u_aea.tif')
names(rs) <- c('exp','K','Th','U')

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')

# extract:
# ~ 12 seconds | 2021, WD
system.time(e <- extract(rs, s))

# set better names
dimnames(e)[[2]] <- c('Exp', 'Potasium', 'Thorium', 'Uranium')

# save for later
save(e, file='E:/gis_data/MLRA/rda/namrad-samples.rda')

rm(s, e, rs)
gc()

