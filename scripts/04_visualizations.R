
library(DESeq2)
library(pheatmap)
dds <- readRDS("results/dds_raw.rds")
vsd <- vst(dds, blind=FALSE)
png("results/PCA_plot.png")
plotPCA(vsd, intgroup="condition")
dev.off()
png("results/heatmap_top_genes.png")
select <- order(rowMeans(counts(dds, normalized=TRUE)), decreasing=TRUE)[1:20]
pheatmap(assay(vsd)[select,], cluster_rows=TRUE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=colData(dds))
dev.off()
