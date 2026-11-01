# Reconstructed SSA + ARIMA analysis (not the original dissertation source code).
# Requires monthly CSV columns year,month,value, with no missing months.
# Component choices must be confirmed against each SSA scree/eigenvector plot.

load_monthly_csv <- function(path) {
  if (!file.exists(path)) stop('Missing input file: ', path)
  d <- read.csv(path, stringsAsFactors = FALSE)
  if (!all(c('year','month','value') %in% names(d)))
    stop('CSV must contain year, month, value columns')
  d <- d[, c('year','month','value')]
  for (nm in names(d)) d[[nm]] <- suppressWarnings(as.numeric(d[[nm]]))
  if (anyNA(d) || any(!is.finite(as.matrix(d)))) stop('Missing/non-numeric values found')
  if (any(d$month != floor(d$month) | d$month < 1 | d$month > 12) ||
      any(d$year != floor(d$year))) stop('Invalid year or month')
  d <- d[order(d$year,d$month), ]
  if (anyDuplicated(paste(d$year,d$month))) stop('Duplicate months')
  dates <- as.Date(sprintf('%04d-%02d-01',as.integer(d$year),as.integer(d$month)))
  if (!identical(dates,seq(min(dates),max(dates),by='month')))
    stop('Missing months; check original source and document any interpolation')
  stats::ts(d$value,start=c(d$year[1],d$month[1]),frequency=12)
}

save_png <- function(path, draw, width=1100, height=700) {
  grDevices::png(path, width=width, height=height)
  tryCatch(draw(), finally=grDevices::dev.off())
}

run_ssa_arima <- function(csv_path, output_dir, dataset, trend=integer(),
                          season=integer(), oscillation=integer(),
                          L=60L,h=24L,units='Value') {
  if (!requireNamespace('Rssa',quietly=TRUE) || !requireNamespace('forecast',quietly=TRUE))
    stop('Install required packages: install.packages(c("Rssa","forecast"))')
  x <- load_monthly_csv(csv_path)
  if (length(x) < 2L * L) stop('Need at least 2*L monthly observations')
  groups <- Filter(function(v) length(v)>0, list(trend=trend,season=season,oscillation=oscillation))
  if (!length(groups)) stop('Choose at least one SSA group')
  idx <- unlist(groups,use.names=FALSE)
  if (anyNA(idx) || any(idx < 1 | idx > L) || any(idx != floor(idx)))
    stop('SSA indices must be integers from 1 to L')
  if (anyDuplicated(idx)) stop('SSA groups overlap: each index must appear once')
  dir.create(output_dir,recursive=TRUE,showWarnings=FALSE)
  s <- Rssa::ssa(x,L=L)
  r <- Rssa::reconstruct(s,groups=groups)
  signal <- stats::ts(Reduce('+',lapply(r,as.numeric)),start=stats::start(x),frequency=12)
  residual <- x - signal
  prefix <- file.path(output_dir,dataset)
  save_png(paste0(prefix,'_raw.png'), function(){ plot(x,main=paste(dataset,'monthly observations'),xlab='Year',ylab=units) })
  save_png(paste0(prefix,'_scree.png'), function(){ plot(s,type='values',main=paste(dataset,'SSA eigenvalue spectrum')) })
  save_png(paste0(prefix,'_eigenvectors.png'), function(){ plot(s,type='vectors',idx=1:min(12,L),main=paste(dataset,'SSA eigenvectors')) })
  for (group_name in names(groups)) {
    component <- stats::ts(as.numeric(r[[group_name]]),start=stats::start(x),frequency=12)
    save_png(paste0(prefix,'_',group_name,'.png'),local({ y <- component; nm <- group_name; function() plot(y,main=paste(dataset,'SSA',nm),xlab='Year',ylab=units) }))
  }
  save_png(paste0(prefix,'_reconstruction.png'),function(){
    plot(x,main=paste(dataset,'observed vs reconstructed'),xlab='Year',ylab=units)
    lines(signal,col='red',lwd=2);legend('topleft',c('Observed','SSA signal'),col=c('black','red'),lty=1,bty='n')
  })
  save_png(paste0(prefix,'_residual.png'),function(){plot(residual,main=paste(dataset,'SSA residual'),xlab='Year',ylab=units);abline(h=0,lty=2)})
  fit <- forecast::auto.arima(signal,seasonal=TRUE)
  fc <- forecast::forecast(fit,h=h,level=c(80,95))
  save_png(paste0(prefix,'_forecast.png'),function(){
    plot(fc,main=paste(dataset,'SSA-ARIMA',h,'month forecast'),xlab='Year',ylab=units)
    lines(x,col='grey50');lines(signal,col='red',lwd=2)
    legend('topleft',c('Observed','SSA signal','ARIMA forecast'),col=c('grey50','red','blue'),lty=1,bty='n')
  })
  write.csv(data.frame(year=as.numeric(time(x)),observed=as.numeric(x),reconstructed=as.numeric(signal),residual=as.numeric(residual)),paste0(prefix,'_reconstruction.csv'),row.names=FALSE)
  write.csv(data.frame(year=as.numeric(time(fc$mean)),mean=as.numeric(fc$mean),lo80=as.numeric(fc$lower[,1]),hi80=as.numeric(fc$upper[,1]),lo95=as.numeric(fc$lower[,2]),hi95=as.numeric(fc$upper[,2])),paste0(prefix,'_forecast.csv'),row.names=FALSE)
  capture.output(list(dataset=dataset,observations=length(x),window=L,selected_groups=groups,arima=fit),file=paste0(prefix,'_model_notes.txt'))
  message('Finished ',dataset,'; plots saved to ',output_dir)
  invisible(list(series=x,ssa=s,components=r,signal=signal,residual=residual,arima=fit,forecast=fc))
}
