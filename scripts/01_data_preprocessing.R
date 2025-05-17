# Load required library
library(DESeq2)
library(org.Hs.eg.db)

# Create results directory if missing
dir.create("results", showWarnings = FALSE)

# Load data
control <- read.csv("data/simulated_counts_control_realgenes.csv", row.names = 1)
treated <- read.csv("data/simulated_counts_treated_realgenes.csv", row.names = 1)
metadata <- read.csv("data/metadata.csv")

# Combine count data
counts <- cbind(control, treated)
colData <- data.frame(row.names = colnames(counts), condition = metadata$Condition)

# Create DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = counts, colData = colData, design = ~condition)

# Replace rownames with real gene symbols
real_symbols <- sample(keys(org.Hs.eg.db, keytype = "SYMBOL"), size = nrow(dds), replace = FALSE)
rownames(dds) <- real_symbols

# Save raw DESeq2 object
saveRDS(dds, file = "results/dds_raw.rds")