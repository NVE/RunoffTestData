
# Load libraries

library(NVEDATA)
library(lubridate)


# Select stations

stat_keep <- c("103.1", "103.40", "104.23", "105.1", "107.3", "109.29", 
               "109.42", "109.9", "112.8", "12.150", "12.171", "12.178", "12.192", 
               "12.193", "12.209", "12.215", "12.286", "12.290", "12.70", "12.97", 
               "121.20", "122.11", "122.17", "122.9", "123.31", "124.2", "127.11", 
               "127.13", "133.7", "138.1", "139.15", "139.35", "148.2", "15.15", 
               "15.21", "15.49", "15.53", "15.79", "151.15", "152.4", "156.10", 
               "157.3", "16.122", "16.132", "16.140", "16.193", "16.66", "16.75", 
               "160.7", "161.7", "162.3", "163.5", "165.6", "168.2", "173.8", 
               "174.11", "174.3", "177.4", "18.10", "19.107", "191.2", "196.35", 
               "2.11", "2.142", "2.145", "2.265", "2.268", "2.279", "2.28", 
               "2.291", "2.32", "2.323", "2.439", "2.463", "2.479", "2.604", 
               "2.614", "2.633", "2.634", "20.2", "200.4", "203.2", "206.3", 
               "208.3", "21.47", "212.10", "212.49", "22.16", "22.22", "22.4", 
               "223.2", "230.1", "234.13", "234.18", "24.8", "24.9", "247.3", 
               "25.24", "25.32", "26.20", "26.26", "26.29", "27.16", "27.24", 
               "28.7", "3.22", "311.460", "311.6", "313.10", "35.16", "36.9", 
               "41.1", "42.2", "46.9", "48.1", "48.5", "50.1", "50.13", "55.4", 
               "55.5", "6.10", "62.10", "62.18", "62.5", "72.5", "73.27", "75.23", 
               "76.5", "77.3", "78.8", "79.3", "8.2", "8.6", "82.4", "83.2", 
               "84.11", "86.12", "87.10", "88.4", "91.2", "97.1", "98.4")

metadata <- get_metadata()
metadata <- metadata[metadata$regine_main %in% stat_keep, ]
regine_main <- metadata$regine_main
area_total <- metadata$area_total

path_runoff <- '//hdata/fou/Avrenningskart/Data/Runoff_All'


# Load data for period calib

time_vec <- seq(ymd("2000-09-01"), ymd("2014-12-31"), by = "days")

for (i in 1:length(regine_main)) {
  
  # Read runoff data
  
  qdata <- read_runoff_file(path_runoff, metadata$obs_series[i])
  
  # Convert to mm/day
  
  qdata$Value <- (qdata$Value * 86400 * 1000) / (area_total[i] * 1e6)
  
  # Round values
  
  qdata$Value <- round(qdata$Value, digits = 2)
  
  # Add to data frame
  
  qdf_calib <- data.frame(Time = qdata$Time, Qobs = qdata$Value)
  
  # Select time period
  
  istart <- which(qdata$Time == head(time_vec, 1))
  istop <- which(qdata$Time == tail(time_vec, 1))
  
  qdf_calib <- qdf_calib[istart:istop, ]
  
  # Save to file
  
  write.table(qdf_calib, file = paste("../24h/Period_Calib/", regine_main[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, quote = FALSE)
  
}


# Load data for period valid

time_vec <- seq(ymd("1985-09-01"), ymd("2000-08-31"), by = "days")

for (i in 1:length(regine_main)) {
  
  # Read runoff data
  
  qdata <- read_runoff_file(path_runoff, metadata$obs_series[i])
  
  # Convert to mm/day
  
  qdata$Value <- (qdata$Value * 86400 * 1000) / (area_total[i] * 1e6)
  
  # Round values
  
  qdata$Value <- round(qdata$Value, digits = 2)
  
  # Add to data frame
  
  qdf_valid <- data.frame(Time = qdata$Time, Qobs = qdata$Value)
  
  # Select time period
  
  istart <- which(qdata$Time == head(time_vec, 1))
  istop <- which(qdata$Time == tail(time_vec, 1))
  
  qdf_valid <- qdf_valid[istart:istop, ]
  
  # Save to file
  
  write.table(qdf_valid, file = paste("../24h/Period_Valid/", regine_main[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, quote = FALSE)
  
}


# Save metadata to file

write.table(metadata, file = "../Metadata.txt", sep = ",", row.names = FALSE, quote = FALSE)
