
# Load libraries

library(NVEDATA)
library(lubridate)


# Select stations

metadata <- get_metadata()
metadata <- metadata[metadata$br23_HBV == "Y", ]
regine_main <- metadata$regine_main
area_total <- metadata$area_total

path_runoff <- '//hdata/fou/Avrenningskart/Data/Runoff_All'


# Load data for period calib

time_vec <- seq(ymd("1975-10-01"), ymd("1995-09-30"), by = "days")

for (i in 1:length(regine_main)) {
  
  # Read runoff data
  
  qdata <- read_runoff_file(path_runoff, metadata$obs_series[i])
  
  # Convert to mm/day
  
  qdata$Value <- (qdata$Value * 86400 * 1000) / (area_total[i] * 1e6)
  
  # Round values
  
  qdata$Value <- round(qdata$Value, digits = 2)
  
  # Add to data frame
  
  qdf <- data.frame(Time = qdata$Time, Qobs = qdata$Value)
  
  # Select time period
  
  istart <- which(qdata$Time == head(time_vec, 1))
  istop <- which(qdata$Time == tail(time_vec, 1))
  
  qdf <- qdf[istart:istop, ]
  
  # Save to file
  
  write.table(qdf, file = paste("../24h/Period_Calib/", regine_main[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, quote = FALSE)
  
}


# Load data for period valid

time_vec <- seq(ymd("1995-10-01"), ymd("2015-09-30"), by = "days")

for (i in 1:length(regine_main)) {
  
  # Read runoff data
  
  qdata <- read_runoff_file(path_runoff, metadata$obs_series[i])
  
  # Convert to mm/day
  
  qdata$Value <- (qdata$Value * 86400 * 1000) / (area_total[i] * 1e6)
  
  # Round values
  
  qdata$Value <- round(qdata$Value, digits = 2)
  
  # Add to data frame
  
  qdf <- data.frame(Time = qdata$Time, Qobs = qdata$Value)
  
  # Select time period
  
  istart <- which(qdata$Time == head(time_vec, 1))
  istop <- which(qdata$Time == tail(time_vec, 1))
  
  qdf <- qdf[istart:istop, ]
  
  # Save to file
  
  write.table(qdf, file = paste("../24h/Period_Valid/", regine_main[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, quote = FALSE)
  
}


# Save metadata to file

write.table(metadata, file = "../Metadata.txt", sep = ",", row.names = FALSE, quote = FALSE)
