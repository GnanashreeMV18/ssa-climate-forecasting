# ssa-climate-forecasting
Singular Spectrum Analysis for long-term climate forecasting | MSc dissertation, Cardiff University
# Time Series Analysis and Forecasting with Applications in Climate Science

MSc Data Science & Analytics dissertation, School of Mathematics, Cardiff University (Dec 2025)
Supervised by Prof. Andrey Pepelyshev

## What this project is
Climate data is noisy, seasonal and trending all at once, which makes it hard to separate real signal from short-term noise. This project applies Singular Spectrum Analysis (SSA) to four major climate datasets to decompose each series into trend, seasonal and oscillatory components, then forecasts each one forward using ARIMA on the SSA-reconstructed signal.

## What I investigated
- Can SSA cleanly separate long-term trend, seasonal cycles and noise across very different types of climate series?
- What do the extracted trends say physically about atmospheric CO₂, ocean-atmosphere variability (ENSO), global warming and Arctic sea ice loss?
- How well does an SSA + ARIMA pipeline forecast each series 24 months ahead?
- How do the four datasets relate to each other as parts of one climate system?

## SSA in plain English
Think of a song made of many instruments playing together. SSA is like an equaliser that splits the recording into separate tracks: the slow bassline (long-term trend), the repeating beat (seasonal cycles) and the background hiss (noise). Once each track is separated, you can forecast the meaningful ones and ignore the hiss. Unlike classical Fourier methods, SSA doesn't assume the signal is linear or perfectly periodic, which matters for messy real-world climate data.

## Data
Four long, high-quality monthly datasets from major scientific organisations:
- **Atmospheric CO₂** — Mauna Loa Observatory, NASA/NOAA (1958–2023)
- **ENSO Index** — NOAA Niño 3.4 monthly index (1950–2023)
- **Global Temperature Anomalies** — NASA GISTEMP (1950–2023 subset)
- **Arctic Sea Ice Extent** — NSIDC Sea Ice Index (1979–2023)

Together these cover the atmosphere, ocean and cryosphere: one indicator of human-driven forcing (CO₂), one of natural interannual variability (ENSO), one direct measure of warming (temperature), and one sensitive downstream effect (sea ice).

## Method
1. Load and clean each monthly series, convert to a time-series object
2. **Embedding:** transform the series into a trajectory matrix (window length L = 60 months, ≈5 years, to capture both annual and lower-frequency cycles)
3. **SVD decomposition:** split the trajectory matrix into eigen-components
4. **Component grouping:** trend, seasonal and noise, guided by the scree plot and eigenvector patterns
5. **Reconstruction:** recombine grouped components into clean trend/seasonal series
6. **Forecasting:** fit ARIMA to the SSA-reconstructed series and produce a 24-month forecast

Built in R 4.4.0 / RStudio, using `Rssa` (SSA decomposition/reconstruction), `forecast` (ARIMA modelling), `readr`/`dplyr` (preprocessing) and `ggplot2` (plotting).

## Key findings
- **CO₂:** strong, accelerating upward trend with a clear annual cycle; growth rate visibly accelerates from around 2000, consistent with industrial growth. Forecast shows continued increase.
- **ENSO:** clear 2–7 year oscillations (El Niño/La Niña cycles) with no long-term trend — confirmed as a natural variability mode rather than a warming driver, but a source of short-term temperature swings.
- **Global temperature:** steady warming trend since around 1970, sharply accelerating after 1998. Forecast shows continued warming.
- **Arctic sea ice:** steady, accelerating decline since 1979, with the downward trend dominating even as seasonal cycles persist. Forecast shows continued loss.
- Read together, the four series tell a consistent story: rising CO₂ drives warming, warming accelerates Arctic ice loss, and ENSO modulates short-term variability on top of that trend.

## Limitations
Findings are scoped honestly in the dissertation: SSA results are sensitive to the choice of window length; ARIMA assumes stationary residuals, which climate trends can violate; 24-month forecasts are treated as probabilistic trends, not deterministic predictions; and neither model captures external forcing (volcanic activity, policy change) or nonlinear feedback.

## Repo contents
- `report/`: full dissertation PDF (subject to any access restriction Cardiff University applies)
- `code/`: R scripts/notebooks for the SSA + ARIMA pipeline
- `figures/`: key plots (scree plots, trend/seasonal decompositions, forecasts)

## Author
Gnanashree Mysuru Venkatesh · Cardiff, UK · [www.linkedin.com/in/gnanashree-mysuru-venkatesh]
