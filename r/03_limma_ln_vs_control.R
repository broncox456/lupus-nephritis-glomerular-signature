library(GEOquery)
library(limma)

# Load data
gse_list <- readRDS("data/raw/gse32591_gse_list.rds")
eset <- gse_list[[1]]

expr_mat <- exprs(eset)
pheno <- pData(eset)
feature_data <- fData(eset)

# Recreate sample filtering (same logic as before)
sample_info <- pheno

sample_info$group <- ifelse(
  sample_info$`disease status:ch1` == "LN patient",
  "LN",
  "control"
)

sample_info$tissue_type <- ifelse(
  grepl("glomer", sample_info$`tissue:ch1`, ignore.case = TRUE),
  "glomerular",
  "other"
)

glom_samples <- sample_info[sample_info$tissue_type == "glomerular", ]

# Subset expression matrix
expr_glom <- expr_mat[, rownames(glom_samples)]

# Design matrix
group_factor <- factor(glom_samples$group, levels = c("control", "LN"))
design <- model.matrix(~ group_factor)

# Fit model
fit <- lmFit(expr_glom, design)
fit <- eBayes(fit)

# Extract results
deg_table <- topTable(
  fit,
  coef = "group_factorLN",
  number = Inf,
  sort.by = "P"
)

deg_table$feature_id <- rownames(deg_table)

# Add gene symbols if available
if ("Gene Symbol" %in% colnames(feature_data)) {
  deg_table <- merge(
    deg_table,
    feature_data[, c("ID", "Gene Symbol")],
    by.x = "feature_id",
    by.y = "ID",
    all.x = TRUE
  )
}

# Save results
dir.create("results/tables", recursive = TRUE, showWarnings = FALSE)

write.table(
  deg_table,
  file = "results/tables/ln_glomerular_limma_results.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

cat("limma analysis completed\n")
cat("Samples used:", nrow(glom_samples), "\n")
cat("Results saved to results/tables/ln_glomerular_limma_results.tsv\n")