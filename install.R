install.packages("readr")
install.packages("BiocManager", repos = "https://cran.r-project.org")
BiocManager::install(c(
  "DESeq2", "clusterProfiler", "org.Hs.eg.db",
  "AnnotationDbi", "KEGGREST", "GO.db", "DOSE",
  "GOSemSim", "enrichplot", "Biostrings"
))
install.packages(c("ggplot2", "pheatmap"))
