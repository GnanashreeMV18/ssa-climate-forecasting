# NASA GISTEMP. The report discusses different sample ranges: verify raw series.
# Component 1 (trend), 2:3 (oscillation) and 4:5 (season) are PROVISIONAL.
source('code/ssa_pipeline.R')
temperature_result <- run_ssa_arima('data/temperature.csv','figures/generated','temperature',
                                    trend=1,oscillation=2:3,season=4:5,
                                    L=60,h=24,units='Temperature anomaly (degrees C)')
