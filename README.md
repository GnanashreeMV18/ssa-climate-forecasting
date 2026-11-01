# Time Series Analysis and Forecasting with Applications in Climate Science

**MSc Data Science and Analytics Dissertation | Cardiff University | December 2025**

**Supervisor:** Prof. Andrey Pepelyshev

## Project Overview

This project investigates long-term climate patterns using **Singular Spectrum Analysis (SSA)** and **Autoregressive Integrated Moving Average (ARIMA)** forecasting.

The study examines four major climate indicators, identifying underlying trends, seasonal behaviour, and multi-year oscillations before generating 24-month forecasts.

## Datasets

| Dataset | Source | Study Period |
|---|---|---|
| Atmospheric CO₂ | NOAA Mauna Loa Observatory | 1958–2023 |
| ENSO | NOAA | 1950–2023 |
| Global Temperature Anomalies | NASA GISTEMP | 1950–2023 |
| Arctic Sea Ice Extent | NSIDC | 1979–2023 |

## Methodology

1. Data collection, cleaning and preprocessing
2. Conversion into monthly time-series objects
3. Singular Spectrum Analysis with window length L = 60
4. Singular value decomposition and eigenvector analysis
5. Reconstruction of trend, seasonal and oscillatory components
6. ARIMA forecasting over a 24-month horizon
7. Visualisation and interpretation of climate trends

## Tools and Technologies

- **Language:** R
- **Libraries:** Rssa, forecast, ggplot2, dplyr, readr
- **Environment:** RStudio
- **Methods:** SSA, SVD, ARIMA, Time Series Forecasting

## Key Findings

**Atmospheric CO₂:** A persistent upward trend with clear annual seasonality.

**ENSO:** Multi-year oscillations associated with El Niño and La Niña, influencing short-term climate variability.

**Global Temperature:** A long-term warming trend with shorter-term fluctuations.

**Arctic Sea Ice:** A long-term decline in extent alongside strong seasonal cycles.

## Dissertation

[Read the full MSc dissertation](SSA-Climate-Forecasting-Dissertation.pdf)

## Code and Reproducibility

This repository also contains R scripts reconstructed from the dissertation methodology. These are **not the recovered original dissertation scripts** and have not yet been fully executed or validated against the submitted figures.

The repository currently includes the prepared NOAA CO₂ dataset. The ENSO, temperature and sea-ice datasets must still be added.

See [Reconstructed Code Documentation](README_RECONSTRUCTED.md) for details.

## Author

**Gnanashree Mysuru Venkatesh**

MSc Data Science and Analytics, Cardiff University

[LinkedIn](https://www.linkedin.com/in/gnanashree-mysuru-venkatesh/)
