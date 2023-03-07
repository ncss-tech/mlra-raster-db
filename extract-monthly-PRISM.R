library(terra)

# monthly data

# PPT (mm)
ppt <- rast('E:/gis_data/prism/final_monthly_ppt_800m.tif')
names(ppt) <- paste('ppt.', 1:12, sep = '')

# PET (mm)
pet <- rast('E:/gis_data/prism/final_monthly_pet_800m.tif')
names(pet) <- paste('pet.', 1:12, sep = '')


# pre-made sampling points AEA
# spatVector
s <- readRDS('E:/gis_data/MLRA/rda/samples.rds')

# back to GCS NAD83
s <- project(s, 'EPSG:4296')


# extract
# ~ 1.9 seconds | 2021, WD
# ~ 4.5 seconds | 2023, exclusions
system.time(e.ppt <- extract(ppt, s, ID = FALSE))

# ~ 1.9 seconds | 2021, WD
# ~ 6.3 seconds | 2023, exclusions
system.time(e.pet <- extract(pet, s, ID = FALSE))

# save for later
saveRDS(e.ppt, file = 'E:/gis_data/MLRA/rda/prism-monthly-ppt-samples.rds')
saveRDS(e.pet, file = 'E:/gis_data/MLRA/rda/prism-monthly-pet-samples.rds')

rm(s, e.ppt, e.pet, ppt, pet)
gc(reset = TRUE)

