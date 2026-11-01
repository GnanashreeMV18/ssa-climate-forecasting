# Reconstructed R workflow — SSA + ARIMA climate time series

**Status:** educational reconstruction of the methodology described in the December 2025 MSc dissertation, **not the original recovered source code**. Generated outputs have not been verified to reproduce dissertation figures. Original figures are in `figures/dissertation_original/` and are **not** outputs of these scripts.

## Running

From the project root in RStudio:

```r
install.packages(c('Rssa','forecast'))
source('code/co2_analysis.R')      # CO2 only; co2.csv is included
source('code/run_all.R')           # skips any other missing CSVs
```

For each dataset the scripts: check the monthly observations; calculate SSA (L=60); save scree/eigenvector plots; reconstruct selected component groups; calculate residuals; fit `auto.arima()` to the SSA-reconstructed signal; produce 24-month predictions with 80% and 95% intervals; and export images and CSV predictions to `figures/generated/`.

## Scripts

- `code/ssa_pipeline.R` — common loader, SSA diagnostics, reconstructions, ARIMA forecasting, exports.
- `code/co2_analysis.R` — Mauna Loa CO2; trial group 1 trend and 2:5 seasonal/harmonic.
- `code/enso_analysis.R` — NOAA index; trial group 1:2 oscillatory.
- `code/temperature_analysis.R` — NASA global temperature; **provisional** groups.
- `code/arctic_sea_ice_analysis.R` — NSIDC sea ice; **provisional** groups.
- `code/run_all.R` — runs scripts with data available.

## Important source-versus-figure discrepancies

- Dissertation methods specify **L=60**, frequency 12 and **24-month** forecasts; these choices are implemented here.
- The CO2 text describes observations to 2023, but some embedded figures end around the late 1990s. This package uses supplied monthly NOAA observations to 2023, so its plots will differ.
- ENSO methods describe **Niño 3.4** but the figures are labelled **SOI**. These indices are different and should not be silently interchanged.
- Global-temperature figures show a shorter date range than the stated long historical sample. Investigate before claiming a direct replication.
- Some original figures show trends with visible seasonal oscillations; this makes exact component grouping uncertain. The trial indices in reconstructed scripts are **not independently proven original settings**.
- No R runtime verification was available when this package was prepared; run and inspect the code in RStudio before publishing generated output.

## Original figures

`figures/dissertation_original/figure_01.png` through `figure_32.png` are images extracted from the user's dissertation Word document. `FIGURE_INDEX.md` maps each figure. They are provided for reference and comparison, not as regenerated model outputs.

## Data

`data/co2.csv` is provided from the user's NOAA source file. The three other CSV files must be sourced, cleaned, and documented; see `data/README.md`.

## Reproducibility checks

1. Compare time spans and units against the plotted figures in the dissertation.
2. Inspect eigenvalue pairs and eigenvectors to select component indices, adjusting the groupings.
3. Check residuals, forecast diagnostics and data processing decisions.
4. Do not claim results match the dissertation without confirming them numerically.
