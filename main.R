library(sp)
library(rgdal)
library(raster)
library(plyr)
library(reshape2)

### pre-cache samples and extracted values

## generate samples, save as SPDF
# source('generate-samples.R')

## extract 800m PRISM stack
# source('extract-800m-PRISM.R')

## extract monthly 800m PRISM stack
# source('extract-monthly-PRISM.R')

## extract NAMRAD stack
# source('extract-namrad.R')

## extract 800m SSURGO/STATSGO stack
# source('extract-800m-soil.R')

## extract 30m geomorphons
# source('extract-geomorphons.R')

## extract 30m NLCD
# source('extract-nlcd.R')

## extract 1km 2015 population count
# source('extract-2015-population-count.R')


### load cached data and combine
load('E:/gis_data/MLRA/rda/samples.rda')


## create table of MLRA code + 2015 population count
load('E:/gis_data/MLRA/rda/pop2015-samples.rda')

# row-order is preserved, combine columns
mlra.pop2015.data <- data.frame(mlra=s$mlra, e, stringsAsFactors = FALSE)
# keep original names, broken by line above
names(mlra.pop2015.data) <- c('mlra', 'pop2015')

save(mlra.pop2015.data, file='E:/gis_data/MLRA/db/mlra-pop2015-data.rda')
rm(e, mlra.pop2015.data)
gc(reset = TRUE)



## create table of MLRA code + NAMRAD stack
load('E:/gis_data/MLRA/rda/namrad-samples.rda')

# row-order is preserved, combine columns
mlra.namrad.data <- data.frame(mlra=s$mlra, e, stringsAsFactors = FALSE)
# keep original names, broken by line above
names(mlra.namrad.data) <- c('mlra', dimnames(e)[[2]])

save(mlra.namrad.data, file='E:/gis_data/MLRA/db/mlra-namrad-data.rda')
rm(e, mlra.namrad.data)
gc(reset = TRUE)


## create table of MLRA code + 800m soil stack
load('E:/gis_data/MLRA/rda/soil-properties-samples.rda')

# row-order is preserved, combine columns
mlra.soil.data <- data.frame(mlra=s$mlra, e, stringsAsFactors = FALSE)
# keep original names, broken by line above
names(mlra.soil.data) <- c('mlra', dimnames(e)[[2]])

save(mlra.soil.data, file='E:/gis_data/MLRA/db/mlra-soil-data.rda')
rm(e, mlra.soil.data)
gc(reset = TRUE)


## create table of MLRA code + PRISM stack
load('E:/gis_data/MLRA/rda/prism-samples.rda')

# row-order is preserved, combine columns
mlra.prism.data <- data.frame(mlra=s$mlra, e, stringsAsFactors = FALSE)
# keep original names, broken by line above
names(mlra.prism.data) <- c('mlra', dimnames(e)[[2]])

save(mlra.prism.data, file='E:/gis_data/MLRA/db/mlra-prism-data.rda')
rm(e, mlra.prism.data)
gc(reset = TRUE)


## create table of MLRA code + monthly PET (PRISM) stack
load('E:/gis_data/MLRA/rda/prism-monthly-pet-samples.rda')

# row-order is preserved, combine columns
pet.prism.data <- data.frame(mlra=s$mlra, e.pet, stringsAsFactors = FALSE)
# keep original names, broken by line above
names(pet.prism.data) <- c('mlra', dimnames(e.pet)[[2]])

save(pet.prism.data, file='E:/gis_data/MLRA/db/mlra-monthly-pet-data.rda')
rm(e.pet, pet.prism.data)
gc(reset = TRUE)


## create table of MLRA code + monthly PPT (PRISM) stack
load('E:/gis_data/MLRA/rda/prism-monthly-ppt-samples.rda')

# row-order is preserved, combine columns
ppt.prism.data <- data.frame(mlra=s$mlra, e.ppt, stringsAsFactors = FALSE)
# keep original names, broken by line above
names(ppt.prism.data) <- c('mlra', dimnames(e.ppt)[[2]])

save(ppt.prism.data, file='E:/gis_data/MLRA/db/mlra-monthly-ppt-data.rda')
rm(e.ppt, ppt.prism.data)
gc(reset = TRUE)



## create table of MLRA code + geomorphon proportions
load('E:/gis_data/MLRA/rda/geomorphons-samples.rda')

# row-order is preserved: add to existing column
s$geomorphons <- e
# keep only DF
s <- s@data

# https://grass.osgeo.org/grass70/manuals/addons/r.geomorphon.html
s$geomorphons <- factor(s$geomorphons, levels=1:10, labels = c('flat', 'summit', 'ridge', 'shoulder', 'spur', 'slope', 'hollow', 'footslope', 'valley', 'depression'))

# tabulate and convert to proportions
x <- xtabs(~ mlra + geomorphons, data=s)
x <- sweep(x, MARGIN = 1, STATS = rowSums(x), FUN = '/')

# conversion to data.frame results in long-format
mlra.geomorphons.data <- as.data.frame(x)

# save
save(mlra.geomorphons.data, file='E:/gis_data/MLRA/db/mlra-geomorphons-data.rda')
rm(s, e, x, mlra.geomorphons.data)
gc(reset = TRUE)


## create table of MLRA code + NLCD proportions
load('E:/gis_data/MLRA/rda/samples.rda')
load('E:/gis_data/MLRA/rda/nlcd-samples.rda')

# row-order is preserved: add to existing column
s$nlcd <- e
# keep only DF
s <- s@data

# These are from the NLCD 2011 metadata
nlcd.leg <- structure(list(ID = c(0L, 11L, 12L, 21L, 22L, 23L, 24L, 31L, 
                                  41L, 42L, 43L, 51L, 52L, 71L, 72L, 73L, 74L, 81L, 82L, 90L, 95L
), name = c("nodata", "Open Water", "Perennial Ice/Snow", "Developed, Open Space", 
            "Developed, Low Intensity", "Developed, Medium Intensity", "Developed, High Intensity", 
            "Barren Land (Rock/Sand/Clay)", "Deciduous Forest", "Evergreen Forest", 
            "Mixed Forest", "Dwarf Scrub", "Shrub/Scrub", "Grassland/Herbaceous", 
            "Sedge/Herbaceous", "Lichens", "Moss", "Pasture/Hay", "Cultivated Crops", 
            "Woody Wetlands", "Emergent Herbaceous Wetlands")), .Names = c("ID", "name"), row.names = c(NA, -21L), class = "data.frame")

# set factor levels
s$nlcd <- factor(s$nlcd, levels = nlcd.leg$ID, labels = nlcd.leg$name)

# tabulate and convert to proportions
x <- xtabs(~ mlra + nlcd, data=s)
# rounding to remove "tiny" fractions -> simpler legend
x <- round(sweep(x, MARGIN = 1, STATS = rowSums(x), FUN = '/'), 3)

# remove 0's
idx <- which(apply(x, 2, function(i) any(i > 0.001)))
x <- x[, idx]

# conversion to data.frame results in long-format
mlra.nlcd.data <- as.data.frame(x)

# save
save(mlra.nlcd.data, file='E:/gis_data/MLRA/db/mlra-nlcd-data.rda')

# done

