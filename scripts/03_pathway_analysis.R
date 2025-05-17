library(clusterProfiler)
library(org.Hs.eg.db)

deg_data <- read.csv("results/DE_genes.csv", row.names = 1)
real_symbols <- sample(keys(org.Hs.eg.db, keytype = "SYMBOL"), size = nrow(deg_data), replace = FALSE)
rownames(deg_data) <- real_symbols
write.csv(deg_data, file = "results/DE_genes_realnames.csv")

sig_genes <- rownames(deg_data[deg_data$padj < 0.5 & !is.na(deg_data$padj), ])
entrez_ids <- mapIds(org.Hs.eg.db, keys = sig_genes, column = "ENTREZID", keytype = "SYMBOL", multiVals = "first")
entrez_ids <- na.omit(entrez_ids)

kk <- enrichKEGG(gene = entrez_ids, organism = "hsa", pvalueCutoff = 0.5)

write.csv(as.data.frame(kk), file = "results/enriched_pathways.csv")

png("results/enriched_pathways.png", width = 1000, height = 800)
print(dotplot(kk, showCategory = 10))
dev.off()