# CO2: Mauna Loa monthly mean, study cutoff December 2023.
# Report: L=60, component 1 dominant, 2-3 annual pair, 4-5 secondary harmonic.
# Optional 4-5 harmonic is included here; compare plots with dissertation figures 5-10, 29.
source('code/ssa_pipeline.R')
co2_result <- run_ssa_arima('data/co2.csv','figures/generated','co2',
                            trend=1,season=2:5,oscillation=integer(),
                            L=60,h=24,units='CO2 (ppm)')
