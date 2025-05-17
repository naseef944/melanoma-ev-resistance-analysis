library(DESeq2)
library(ggplot2)

dds <- readRDS("results/dds_raw.rds")
dds <- DESeq(dds)
vsd <- vst(dds, blind = FALSE)
normalized_counts <- counts(dds, normalized = TRUE)
normalized_counts <- normalized_counts[rowSums(normalized_counts) > 0, ]

# PCA Plot
png("results/PCA_plot.png", width = 1000, height = 600)
plotPCA(vsd, intgroup = "condition")
dev.off()

# Barplot of Top 20 Genes
shared_genes <- intersect(rownames(normalized_counts), rownames(assay(vsd)))
avg_expr <- rowMeans(normalized_counts[shared_genes, ])
top_20 <- sort(avg_expr, decreasing = TRUE)[1:20]

plot_df <- data.frame(
  gene = factor(names(top_20), levels = names(top_20)),
  mean_expression = as.numeric(top_20)
)

png("results/barplot_top_genes.png", width = 1000, height = 600)
ggplot(plot_df, aes(x = gene, y = mean_expression)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    theme_minimal() +
    labs(title = "Top 20 Expressed Genes", x = "Gene", y = "Mean Normalized Expression") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
dev.off()