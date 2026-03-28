import pandas as pd
import numpy as np

df = pd.read_csv("results/tables/ln_glomerular_limma_results.tsv", sep="\t")

# choose best available gene column
if "Gene.Symbol" in df.columns:
    gene_col = "Gene.Symbol"
elif "Gene Symbol" in df.columns:
    gene_col = "Gene Symbol"
else:
    gene_col = "feature_id"

df["gene"] = df[gene_col].fillna(df["feature_id"])

df["score"] = df["logFC"].abs() * -np.log10(df["adj.P.Val"].clip(lower=1e-300))

df = df.sort_values("score", ascending=False)

df.to_csv("results/tables/ln_glomerular_prioritized.tsv", sep="\t", index=False)

print(df[["gene", "logFC", "adj.P.Val"]].head(10))