library(DESeq2)
library(ggplot2)

dds <- readRDS("results/dds_raw.rds")
dds <- DESeq(dds)
res <- results(dds)
write.csv(as.data.frame(res), file = "results/DE_genes.csv")

# Create volcano plot
res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)

png("results/volcano_plot.png", width = 1000, height = 600)
ggplot(res_df, aes(x = log2FoldChange, y = -log10(pvalue))) +
    geom_point(alpha = 0.5) +
    theme_minimal() +
    xlab("Log2 Fold Change") + ylab("-Log10 p-value") +
    ggtitle("Volcano Plot of Differentially Expressed Genes")
dev.off()