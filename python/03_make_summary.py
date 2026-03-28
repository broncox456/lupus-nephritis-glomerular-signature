import pandas as pd

df = pd.read_csv("results/tables/ln_glomerular_prioritized.tsv", sep="\t")

sig = df[df["adj.P.Val"] < 0.05].copy()

up = sig[sig["logFC"] > 0].sort_values("score", ascending=False).head(10)
down = sig[sig["logFC"] < 0].sort_values("score", ascending=False).head(10)

summary = pd.DataFrame({
    "metric": [
        "total_features",
        "significant_features_fdr_lt_0.05",
        "upregulated_significant",
        "downregulated_significant"
    ],
    "value": [
        len(df),
        len(sig),
        (sig["logFC"] > 0).sum(),
        (sig["logFC"] < 0).sum()
    ]
})

summary.to_csv("results/tables/ln_glomerular_summary_metrics.tsv", sep="\t", index=False)
up.loc[:, ["gene", "logFC", "adj.P.Val", "score"]].to_csv(
    "results/tables/ln_glomerular_top10_up.tsv", sep="\t", index=False
)
down.loc[:, ["gene", "logFC", "adj.P.Val", "score"]].to_csv(
    "results/tables/ln_glomerular_top10_down.tsv", sep="\t", index=False
)

print(summary)
print("\nTop upregulated genes:")
print(up.loc[:, ["gene", "logFC", "adj.P.Val", "score"]])

print("\nTop downregulated genes:")
print(down.loc[:, ["gene", "logFC", "adj.P.Val", "score"]])