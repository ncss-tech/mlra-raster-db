library(sp)
library(rgdal)
library(sharpshootR)
library(igraph)

## Note: weighting used by polygonAdjacency() is based on counts, more useful in the context of map units
# ideas? https://cran.r-project.org/web/packages/spdep/vignettes/nb_igraph.html

mlra <- readOGR(dsn='E:/gis_data/MLRA', layer='conus-mlra-v42', stringsAsFactors = FALSE)

p <- polygonAdjacency(mlra, v='MLRARSYM')


# max spanning tree
png(file='figures/mlra-spatial-neighbors-max-spanning-tree.png', width=1500, height=1500, res=90, type='cairo', antialias = 'subpixel')

par(mar=c(0,0,0,0))
plotSoilRelationGraph(p$adjMat, spanning.tree='max', 
                           edge.scaling.factor=1.5, vertex.scaling.factor=1, 
                           vertex.label.family='sans',
                           vertex.label.cex=0.75,
                           g.layout = layout_with_lgl)

dev.off()


# full graph
png(file='figures/mlra-spatial-neighbors.png', width=1500, height=1500, res=90, type='cairo', antialias = 'subpixel')

par(mar=c(0,0,0,0))
g <- plotSoilRelationGraph(p$adjMat,
                           edge.scaling.factor=1.5, vertex.scaling.factor=1, 
                           vertex.label.family='sans',
                           vertex.label.cex=0.75,
                           g.layout = layout_with_lgl)


dev.off()

# get vertices that are neighbors with a given vertex
neighbors(g, '18')

# plot subgraph
plot(subgraph(g, neighbors(g, '18')), 
     vertex.label.family='sans',
     vertex.label.cex=0.75,
     vertex.label.color='black',
     layout=layout_with_lgl)

# extract by cluser
idx <- which(V(g)$cluster == 8)

png(file='figures/mlra-spatial-close-to-18.png', width=800, height=800, res=90, type='cairo', antialias = 'subpixel')

par(mar=c(0,0,0,0))
plot(subgraph(g, idx), 
     vertex.label.family='sans',
     vertex.label.cex=0.75,
     vertex.label.color='black',
     layout=layout_with_lgl)

dev.off()


## lookup adjancency information for a subset of MLRA
p$adjMat['18', ]


## TODO: save a reasonable representation of the adjacency, for now, an .Rda file
save(p, file='rda-files/mlra-adjacency.rda')


## join groups to spatial data
d <- data.frame(MLRASYM=V(g)$name, cluster=V(g)$cluster, stringsAsFactors = FALSE)

mlra$cluster <- d$cluster[match(mlra$MLRARSYM, d$MLRASYM)]


# hmmm ?

library(sf)

mlra <- st_as_sf(mlra)

plot(mlra[, 'cluster'])

