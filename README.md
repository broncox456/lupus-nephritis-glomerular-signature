# lupus-nephritis-glomerular-signature

Reproducible transcriptomics workflow for differential expression and gene prioritization in human glomerular lupus nephritis.

## Dataset
Primary dataset: GSE32591  
Disease context: lupus nephritis  
Compartment: glomerular transcriptomics

## Stack
- R: GEOquery, limma
- Python: pandas, matplotlib
- PowerShell: execution and project management

## Current scope
1. Download GEO series
2. Export phenotype and expression matrices
3. Prepare glomerular sample metadata
4. Run limma differential expression
5. Prioritize genes and generate figures
