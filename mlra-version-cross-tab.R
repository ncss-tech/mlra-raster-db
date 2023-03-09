library(terra)
library(igraph)
library(corrplot)
library(viridisLite)

# MLRA42
# EPSG:4269
m42 <- vect('e:/gis_data/MLRA/2006_v42/mlra_v42-conus.shp')

# pre-made sampling points
# spatVect EPSG:5070
# contains MLRA52 symbols
s <- readRDS('E:/gis_data/MLRA/rda/samples.rds')

# back to GCS
s <- project(s, 'EPSG:4269')

# subset for testing
x <- s[sample(1:nrow(s), size = 10000)]

# this is painfully slow, why?
x$mlra42 <- extract(m42, x)$MLRARSYM

# keep only those cases where there is a change from version 42 -> 52
z <- x[which(x$mlra != x$mlra42), ]

plot(z)

# combined MLRA symbols
# required for full adjacency matrix
ll <- unique(c(z$mlra, z$mlra42))

# set combined levels
z$mlra <- factor(z$mlra, levels = ll)
z$mlra42 <- factor(z$mlra42, levels = ll)

# tab <- xtabs(~ mlra + mlra42, data = z, sparse = TRUE)

# cross-tab
# 
tab <- xtabs(~ mlra42 + mlra, data = z, drop.unused.levels = FALSE)

# long-format, edges + weight
tab.long <- as.data.frame(tab)
names(tab.long)[3] <- 'weight'

# 10k samples -> 32k records
nrow(tab.long)

# retain only those with non-zero occurrences
tab.long <- tab.long[which(tab.long$weight > 0), ]

# 369 records
nrow(tab.long)

# sort
tab.long <- tab.long[order(tab.long$weight, decreasing = TRUE), ]

# top 10 most frequent transitions
head(tab.long, 10)

# init graph
g <- graph_from_data_frame(tab.long)
is.weighted(g)

# set vertex size
V(g)$size <- 3 + sqrt(10 * degree(g))

# graphical check
par(mar = c(0, 0, 0, 0))
set.seed(1010)
plot(g, layout = layout_with_dh, edge.arrow.size = 0.5, vertex.label.family = 'sans', vertex.label.color = 'black', vertex.label.cex = 0.66)



# highly skewed results, color doesn't work so well 
corrplot(as.matrix(tab), is.corr = FALSE, method = 'shade', col = mako(100), type = 'upper')

