# NSIDC Arctic sea ice extent, monthly values in million km^2.
# Groups 1, 2:3, 4:5 are PROVISIONAL, not confirmed original groupings.
source('code/ssa_pipeline.R')
sea_ice_result <- run_ssa_arima('data/arctic_sea_ice.csv','figures/generated','arctic_sea_ice',
                                trend=1,season=2:3,oscillation=4:5,
                                L=60,h=24,units='Sea ice extent (million km^2)')
