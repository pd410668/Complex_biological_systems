library("ggplot2")
library(Biobase)
library(GEOquery)

data <- getGEO('GDS39', destdir=".")
geneexp <- Table(data)[,-c(1,2)]
geneexp <- as.data.frame(lapply(geneexp, as.numeric))
geneexp <- apply(geneexp,2,as.numeric)

rows_missing <- apply(geneexp, 1, function(x) any(is.na(x)))
geneexp <- geneexp[!rows_missing,]

geneexp.melt <- reshape2::melt(geneexp)
geneexp.melt[1:5,]

ggplot(geneexp.melt, aes(Var1, Var2)) +
  geom_tile(aes(fill=value)) + theme_light() +
  scale_fill_gradient2(low="blue", mid="white", high="yellow", midpoint=0, limits=c(-3,3)) + labs(x="", y="") +
  theme(axis.text.y = element_blank(), axis.text.x = element_blank()) 