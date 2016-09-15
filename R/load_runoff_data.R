
# Load libraries

library(NVEDATA)
library(lubridate)


# Select stations

metadata <- get_metadata()
metadata <- metadata[metadata$br23_HBV == "Y", ]
regine_main <- metadata$regine_main

path_runoff <- '//hdata/fou/Vannbalansekart/Data/Runoff_All'


# Load data for period 1

time_vec <- seq(ymd("1975-10-01"), ymd("1995-09-30"), by = "days")

for (i in 1:length(regine_main)) {
  
  # Read runoff data
  
  qdata <- read_runoff_file(path_runoff, metadata$obs_series[i])
  
  # Add to data frame
  
  qdf <- data.frame(Time = qdata$Time, Qobs = qdata$Value)
  
  # Select time period
  
  istart <- which(qdata$Time == head(time_vec, 1))
  istop <- which(qdata$Time == tail(time_vec, 1))
  
  qdf <- qdf[istart:istop, ]
  
  # Save to file
  
  write.table(qdf, file = paste("../Period1/", regine_main[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, quote = FALSE)
  
}


# Load data for period 2

time_vec <- seq(ymd("1995-10-01"), ymd("2015-09-30"), by = "days")

for (i in 1:length(regine_main)) {
  
  # Read runoff data
  
  qdata <- read_runoff_file(path_runoff, metadata$obs_series[i])
  
  # Add to data frame
  
  qdf <- data.frame(Time = qdata$Time, Qobs = qdata$Value)
  
  # Select time period
  
  istart <- which(qdata$Time == head(time_vec, 1))
  istop <- which(qdata$Time == tail(time_vec, 1))
  
  qdf <- qdf[istart:istop, ]
  
  # Save to file
  
  write.table(qdf, file = paste("../Period2/", regine_main[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, quote = FALSE)
  
}


# Save metadata to file

write.table(metadata, file = "../Metadata.txt", sep = ",", row.names = FALSE, quote = FALSE)
