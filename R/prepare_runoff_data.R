# Load libraries

library(NVEDATA)
library(lubridate)


# Select stations

stat_keep <- c("2.11", "2.28", "2.32", "2.142", "2.145", "2.265", "2.268", 
               "2.279", "2.291", "2.323", "2.439", "2.463", "2.479", "2.604", 
               "2.614", "2.633", "2.634", "3.22", "6.10", "6.71", "8.2", "8.6", 
               "12.70", "12.97", "12.114", "12.150", "12.171", "12.178", "12.192", 
               "12.193", "12.209", "12.215", "12.286", "12.290", "15.21", 
               "15.49", "15.53", "15.79", "15.174", "16.66", "16.75", "16.122", 
               "16.132", "16.140", "16.193", "18.10", "19.107", "20.2", "21.47", 
               "22.4", "22.16", "22.22", "24.8", "24.9", "25.24", "25.32", "26.20", 
               "26.26", "26.29", "27.16", "27.24", "28.7", "35.16", "36.9", 
               "41.1", "42.2", "46.9", "48.1", "48.5", "50.1", "50.13", "55.4", 
               "55.5", "62.5", "62.10", "62.18", "72.5", "73.27", "75.23", "76.5", 
               "77.3", "78.8", "79.3", "82.4", "83.2", "84.11", "86.12", "87.10", 
               "88.4", "91.2", "97.1", "98.4", "103.1", "103.40", "104.23", 
               "105.1", "107.3", "109.9", "109.29", "109.42", "112.8", "121.20", 
               "122.9", "122.11", "122.17", "123.31", "124.2", "127.11", "127.13", 
               "133.7", "138.1", "139.15", "139.35", "148.2", "151.15", "152.4", 
               "156.10", "157.3", "160.7", "161.7", "162.3", "163.5", "165.6", 
               "168.2", "173.8", "174.3", "174.11", "177.4", "191.2", "196.35", 
               "200.4", "203.2", "206.3", "208.3", "212.10", "212.27", "212.49", 
               "223.2", "230.1", "234.13", "234.18", "247.3", "311.6", "311.460", "313.10")

metadata <- get_metadata()
metadata <- metadata[metadata$regine_main %in% stat_keep, ]
regine_main <- metadata$regine_main
area_total <- metadata$area_total

path_runoff <- '//hdata/fou/Avrenningskart/Data/Runoff_All'


# Select calibration and validation periods

time_calib <- seq(ymd("2000-09-01"), ymd("2014-12-31"), by = "days")

time_valid <- seq(ymd("1985-09-01"), ymd("2000-08-31"), by = "days")


# Loop through all stations

regine_main_final <- c()

for (i in 1:length(regine_main)) {
  
  # Read runoff data
  
  qdata <- read_runoff_file(path_runoff, metadata$obs_series[i])
  
  # Convert to mm/day
  
  qdata$Value <- (qdata$Value * 86400 * 1000) / (area_total[i] * 1e6)
  
  # Round values
  
  qdata$Value <- round(qdata$Value, digits = 2)
  
  # Extract data for calibration period
  
  istart <- which(qdata$Time == head(time_calib, 1))
  istop <- which(qdata$Time == tail(time_calib, 1))
  
  qdf_calib <- data.frame(Time = qdata$Time[istart:istop], Qobs = qdata$Value[istart:istop])
  
  # Extract data for validation period
  
  istart <- which(qdata$Time == head(time_valid, 1))
  istop <- which(qdata$Time == tail(time_valid, 1))
  
  qdf_valid <- data.frame(Time = qdata$Time[istart:istop], Qobs = qdata$Value[istart:istop])
  
  # Compute fraction missing data
  
  frac_missing_calib <- sum(is.na(qdf_calib$Qobs)) / length(is.na(qdf_calib$Qobs))
  
  frac_missing_valid <- sum(is.na(qdf_valid$Qobs)) / length(is.na(qdf_valid$Qobs))
  
  # Only save files if fraction missing data is less than threshold
  
  if (frac_missing_calib < 0.3 & frac_missing_valid < 0.3) {
    
    write.table(qdf_calib, file = paste("../24h/qobs_calib/", regine_main[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, quote = FALSE)
    
    write.table(qdf_valid, file = paste("../24h/qobs_valid/", regine_main[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, quote = FALSE)
    
    regine_main_final <- c(regine_main_final, regine_main[i])
    
  }
  
}

# Save metadata for extracted stations

metadata <- get_metadata()
metadata <- metadata[metadata$regine_main %in% regine_main_final, ]

write.table(metadata, file = "../Metadata.txt", sep = ";", row.names = FALSE, quote = FALSE)




