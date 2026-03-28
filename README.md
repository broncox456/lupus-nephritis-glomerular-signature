# lupus-nephritis-glomerular-signature

Reproducible transcriptomics workflow for differential expression and gene prioritization in human glomerular lupus nephritis.

## Clinical question
Which genes are most strongly dysregulated in glomerular lupus nephritis compared with control glomerular tissue?

## Dataset
- **GEO accession:** GSE32591
- **Tissue compartment:** glomerular biopsy samples
- **Comparison:** lupus nephritis vs control
- **Final cohort used:** 46 samples total
  - 32 lupus nephritis
  - 14 controls

## Methods
### R
- GEO data retrieval with `GEOquery`
- Differential expression analysis with `limma`

### Python
- Post-processing and ranking of differentially expressed genes
- Volcano plot generation

## Workflow
1. Download and load GSE32591
2. Export phenotype and expression matrices
3. Filter glomerular samples only
4. Define lupus nephritis vs control groups
5. Run differential expression with `limma`
6. Rank genes by effect size and adjusted p-value
7. Generate volcano plot

## Main outputs
- `results/tables/ln_glomerular_limma_results.tsv`
- `results/tables/ln_glomerular_prioritized.tsv`
- `results/tables/ln_glomerular_top20.tsv`
- `results/figures/volcano_plot.png`

## Additional outputs
- `results/tables/ln_glomerular_summary_metrics.tsv`
- `results/tables/ln_glomerular_top10_up.tsv`
- `results/tables/ln_glomerular_top10_down.tsv`
- `notebooks/01_ln_glomerular_walkthrough.ipynb`

## Key findings
Top-ranked genes included:
- IFI44
- IFI44L
- MX1
- TYROBP
- C1QA
- MX2

These genes are consistent with immune activation and interferon-related biology, which is clinically coherent with lupus nephritis.

## Project structure
```text
data/
  raw/
  metadata/
  processed/
r/


python/
results/
docs/