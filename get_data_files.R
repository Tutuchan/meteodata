### Data source : https://donneespubliques.meteofrance.fr/?fond=produit&id_produit=90&id_rubrique=32

# Monthly data files
years <- 1996:2015
months <- c(paste0("0", 1:9), "10", "11", "12")
baseURL <- "https://donneespubliques.meteofrance.fr/donnees_libres/Txt/Synop/Archive/synop."
for (year in years){
  for (month in months){
    fileName <- paste0(year,month, ".csv.gz")
    cat(paste("Trying file", fileName, "\n"))
    w <- tryCatch(suppressMessages(download.file(fileName, "temp.csv.gz")), warning = function(w) 1)
    # Unzip the file to csv only if no warnings thrown
    if (w == 0){
      fl <- gzfile("temp.csv.gz")
      fLines <- readLines(fl)
      # Replace the "mq" string with NA
      fLines <- gsub("mq", "NA", fLines)
      outFile <- file(paste0("data/meteo/", year, month, ".csv"), "w")
      write(fLines, outFile)
      close(fl)
      close(outFile)
    }
    unlink("temp.csv.gz")
  }
}

# GeoJSON files
download.file("https://donneespubliques.meteofrance.fr/donnees_libres/Txt/Synop/postesSynop.json", "data/geo/meteo.geojson")

# Documentation is at https://donneespubliques.meteofrance.fr/client/document/doc_parametres_synop_168.pdf
