# Run from the repository root (RStudio project directory or setwd() there).
# Missing dataset files are skipped; errors in present datasets stop execution.
script_map <- c(co2='co2_analysis.R',enso='enso_analysis.R',
                temperature='temperature_analysis.R',arctic_sea_ice='arctic_sea_ice_analysis.R')
for (dataset in names(script_map)) {
  path <- file.path('data',paste0(dataset,'.csv'))
  if (!file.exists(path)) {message('SKIP ',dataset,': add ',path);next}
  source(file.path('code',script_map[[dataset]]),local=FALSE)
}
