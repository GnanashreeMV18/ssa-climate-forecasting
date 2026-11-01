# Data inputs

All inputs must be **monthly** CSVs with `year,month,value` headers, one observation per calendar month, no duplicate or missing months, and no NA values. Retain original-source citations and describe any imputations separately.

- `co2.csv`: NOAA Mauna Loa monthly mean through December 2023 (included here; source file `co2_mm_mlo.csv` supplied by project owner). This file may not match the early ending date shown in the dissertation's original CO2 figures.
- `enso.csv`: **not included**. Choose and document NOAA Niño 3.4 or SOI consistently. Those are distinct indices, and the dissertation labels conflict.
- `temperature.csv`: **not included**. NASA GISTEMP monthly series; choose and document the exact study interval.
- `arctic_sea_ice.csv`: **not included**. NSIDC monthly Arctic extent, million km²; document interval.

`run_all.R` skips missing datasets; standalone scripts require their respective CSV.
