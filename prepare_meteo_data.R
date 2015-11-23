prepare_meteo_data = function(paths){
  listDfs <- lapply(paths, function(path) {
    cat(paste("Reading file", basename(path), "\n"))
    dfMeteo <- read.csv2(path)
    # Replace date with date and hour
    dfMeteo$hour <- as.numeric(substr(dfMeteo$date, 9, 10))
    dfMeteo$date <- substr(dfMeteo$date, 1, 8)
    dfMeteo$date <- as.Date(dfMeteo$date, format = "%Y%m%d")
    suppressMessages(dfMeteo %<>%
      inner_join(dfStations) %>% 
      select(numer_sta, Nom, date, hour, everything()))
    dfMeteo
  })
  bind_rows(listDfs)
}
