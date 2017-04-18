# Collect Raster Samples for CONUS MLRA

## Data Sources

 1. 800m PRISM:
    + elevation
    + effective PPT
    + frost-free days
    + MAAT
    + MAP
    + growing degree days
    + fraction of annual PPT as rain
 2. 30m geomorphon proportions
 3. 30m NLCD (2011) proportions
 4. 800m CONUS SSURGO | STATSGO:
    + CEC 0-25cm
    + plant available water storage 0-25cm
    + pH 0-25cm
 
## Get Latest MLRA Raster Sample Database
The following 3 commands will download the three raster sample databases to your home directory. Adjust `destfile` paths as needed. The files should be placed in the MLRA Summary report folder.
```r
download.file('https://github.com/ncss-tech/mlra-raster-db/raw/master/rda-files/mlra-geomorphons-data.rda', destfile='~/mlra-geomorphons-data.rda')
download.file('https://github.com/ncss-tech/mlra-raster-db/raw/master/rda-files/mlra-nlcd-data.rda', destfile='~/mlra-nlcd-data.rda')
download.file('https://github.com/ncss-tech/mlra-raster-db/raw/master/rda-files/mlra-prism-data.rda', destfile='~/mlra-prism-data.rda')
```