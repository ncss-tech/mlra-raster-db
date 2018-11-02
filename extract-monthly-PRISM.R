library(raster)
library(rgdal)
library(sp)

# pre-made sampling points
load('E:/gis_data/MLRA/rda/samples.rda')

## TODO: extract from rasters in memory as with standard prism stack

# monthly data

# PPT (mm)
ppt <- brick('E:/gis_data/prism/final_monthly_ppt_800m.tif')
names(ppt) <- paste('ppt.', 1:12, sep = '')

# PET (mm * 100)
pet <- brick('E:/gis_data/prism/final_monthly_pet_800m.tif')
# convert to mm
pet <- pet / 100.0
names(pet) <- paste('pet.', 1:12, sep = '')

# extract: 27 seconds
system.time(e.ppt <- extract(ppt, s))

# 3 seconds
system.time(e.pet <- extract(pet, s))

# save for later
save(e.ppt, file='E:/gis_data/MLRA/rda/prism-monthly-ppt-samples.rda')
save(e.pet, file='E:/gis_data/MLRA/rda/prism-monthly-pet-samples.rda')

rm(s, e.ppt, e.pet, ppt, pet)
gc(reset = TRUE)

