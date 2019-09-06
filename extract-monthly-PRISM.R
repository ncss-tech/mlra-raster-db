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

# PET (mm)
pet <- brick('E:/gis_data/prism/final_monthly_pet_800m.tif')
names(pet) <- paste('pet.', 1:12, sep = '')

# work from memory
# ~ 16 seconds each with AMP + process-exclusions
system.time(ppt <- readAll(ppt))
system.time(pet <- readAll(pet))

# extract
# ~ 27 seconds (Windows 7)
# ~ 223 seconds from disk with AMP + process-exclusions
# ~ 1.2 seconds from disk with AMP + process-exclusions
system.time(e.ppt <- extract(ppt, s))

# 1.5 seconds from RAM with AMP + process-exclusions
system.time(e.pet <- extract(pet, s))

# save for later
save(e.ppt, file='E:/gis_data/MLRA/rda/prism-monthly-ppt-samples.rda')
save(e.pet, file='E:/gis_data/MLRA/rda/prism-monthly-pet-samples.rda')

rm(s, e.ppt, e.pet, ppt, pet)
gc(reset = TRUE)

