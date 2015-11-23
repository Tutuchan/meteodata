# Data source : https://donneespubliques.meteofrance.fr/?fond=produit&id_produit=90&id_rubrique=32

years <- 1996:2015
months <- c(paste0("0", 1:9), "10", "11", "12")

for (year in years){
  for (month in months){
    w <- warnings()
    download.file(paste0("https://donneespubliques.meteofrance.fr/donnees_libres/Txt/Synop/Archive/synop.", year, month, ".csv.gz"), "temp.csv.gz")
    # Unzip the file to csv only if no warnings thrown
    if (length(warnings()) == length(w)){
      fl <- gzfile("temp.csv.gz")
      fLines <- readLines(fl)
      outFile <- file(paste0("data/", year, month, ".csv"), "w")
      write(fLines, outFile)
    }
    unlink("temp.csv.gz")
  }
}
