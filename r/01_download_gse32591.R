if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

for (pkg in c("GEOquery")) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg, ask = FALSE, update = FALSE)
  }
}

library(GEOquery)

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)

gse_id <- "GSE32591"
gse_list <- getGEO(gse_id, GSEMatrix = TRUE, AnnotGPL = TRUE)

saveRDS(gse_list, file = file.path("data", "raw", "gse32591_gse_list.rds"))

cat("Downloaded", gse_id, "successfully\n")
cat("Number of ExpressionSet objects:", length(gse_list), "\n")

