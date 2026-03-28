library(GEOquery)

gse_list <- readRDS(file.path("data", "raw", "gse32591_gse_list.rds"))
eset <- gse_list[[1]]

expr_mat <- exprs(eset)
pheno <- pData(eset)
feature_data <- fData(eset)

dir.create("data/metadata", recursive = TRUE, showWarnings = FALSE)
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

write.table(
  pheno,
  file = file.path("data", "metadata", "gse32591_pheno.tsv"),
  sep = "\t",
  quote = FALSE,
  row.names = TRUE
)

write.table(
  feature_data,
  file = file.path("data", "metadata", "gse32591_features.tsv"),
  sep = "\t",
  quote = FALSE,
  row.names = TRUE
)

write.table(
  expr_mat,
  file = file.path("data", "processed", "gse32591_expression_matrix.tsv"),
  sep = "\t",
  quote = FALSE,
  row.names = TRUE
)

cat("Metadata and expression matrix exported.\n")
cat("Expression matrix dimensions:", dim(expr_mat)[1], "features x", dim(expr_mat)[2], "samples\n")