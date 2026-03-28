import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv("results/tables/ln_glomerular_limma_results.tsv", sep="\t")

df["y"] = -np.log10(df["adj.P.Val"].clip(lower=1e-300))

plt.figure()
plt.scatter(df["logFC"], df["y"], s=10)

plt.xlabel("logFC")
plt.ylabel("-log10 adj p")
plt.title("LN vs Control (Glomerular)")

plt.savefig("results/figures/volcano_plot.png", dpi=300)
plt.close()

print("plot OK")
