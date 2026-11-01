# CAUTION: Dissertation prose says NOAA Nino 3.4, while plotted figures say SOI.
# Use the exact index you intend to analyse; do not mix SOI with Nino 3.4 data.
# Components 1:2 are a PROVISIONAL initial grouping from the report's discussion.
source('code/ssa_pipeline.R')
enso_result <- run_ssa_arima('data/enso.csv','figures/generated','enso',
                             oscillation=1:2,L=60,h=24,units='ENSO index (source-defined)')
