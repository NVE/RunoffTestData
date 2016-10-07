# Functions for reading modelled and observed runoff


# Read observed discharge (files in folder Period_Calib and Period_Valid)
# Returns a data frame with columns Time, Station 1, Station 2 ...

load_runoff_obs <- function(path_obs = "Period_Valid") {
  
  files_data <- list.files(path_obs)
  
  files_data <- sort(files_data)
  
  list_data <- vector("list", length(files_data))
  
  for (ifile in 1:length(files_data)) {
    
    tmp <- read.table(paste(path_obs, "/", files_data[ifile], sep = "") , header = TRUE, sep = "\t")
    
    list_data[[ifile]]$q_obs <- tmp$Qobs
    
  }
  
  q_mat <- sapply(list_data, function(tmp) tmp$q_obs)
  
  q_obs <- data.frame(as.Date(tmp$Time), q_mat)
  
  colnames(q_obs) <- c("Time", gsub(".txt","",files_data))
  
  return(q_obs)
  
}


# Read simulated discharge from Jhydro models

load_jhydro_res <- function(path_model) {
  
  files_data <- list.files(path_model)
  
  files_data <- sort(files_data)
  
  list_data <- vector("list", length(files_data))
  
  for (ifile in 1:length(files_data)) {
    
    tmp <- read.table(paste(path_model, "/", files_data[ifile], sep = ""), header = TRUE)
    
    list_data[[ifile]]$q_sim <- tmp$q_sim
    
  }
  
  q_mat <- sapply(list_data, function(tmp) tmp$q_sim)
  
  q_sim <- data.frame(as.Date(tmp$date), q_mat)
  
  station_names <- gsub("_station.txt", "", files_data)
  
  station_names <- gsub("_", ".", station_names)
  
  colnames(q_sim) <- c("Time", station_names)
  
  return(q_sim)
  
}







