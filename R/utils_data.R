# Functions for reading modelled and observed runoff


# Read observed discharge (files in folder Period_Calib and Period_Valid)
# Returns a data frame with columns Time, Station 1, Station 2 ...

load_runoff_obs <- function(path_obs) {
  
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


# Read simulated discharge from Vann models

load_vann_res <- function(path_model) {
  
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


# Read simulated discharge from HBV model (fortran code)

load_hbv_res <- function(path_model) {
  
  # Load data
  
  files_data <- list.files(path_model)
  
  files_data <- sort(files_data)
  
  list_data <- vector("list", length(files_data))
  
  for (ifile in 1:length(files_data)) {
    
    tmp <- read.table(paste(path_model, "/", files_data[ifile], sep = ""), header = TRUE)
    
    list_data[[ifile]]$q_sim <- tmp$Qim_m3s    ##### Is mm/day even though name suggests m3/day
    
  }
  
  q_mat <- sapply(list_data, function(tmp) tmp$q_sim)
  
  q_sim <- data.frame(as.Date(tmp$dato), q_mat)
  
  station_names <- gsub(".Qsim.txt", "", files_data)
  
  colnames(q_sim) <- c("Time", station_names)
  
  return(q_sim)
  
}



# Read simulated discharge from DDD model

load_ddd_res <- function(path_model) {
  
  # Libraries
  
  require(lubridate)
  
  # Metadata
  
  metadata <- read.table("Metadata.txt", header = TRUE, sep = ";")
  
  # Load data
  
  files_data <- list.files(path_model)
  
  files_data <- sort(files_data)
  
  list_data <- vector("list", length(files_data))
  
  for (ifile in 1:length(list_data)) {
    
    print(paste("Read file:", files_data[ifile], sep = " "))
    
    tmp <- read.table(paste(path_model, "/", files_data[ifile], sep = ""), header = FALSE)
    
    print(paste("Number of lines:", nrow(tmp), sep = " "))
    
    list_data[[ifile]]$q_sim <- tmp$V8
    
  }
  
  # Create data frame
  
  q_mat <- sapply(list_data, function(tmp) tmp$q_sim)
  
  time_vec <- ymd(paste(tmp$V1, tmp$V2, tmp$V3, sep="-"))
  
  q_sim <- data.frame(time_vec, q_mat)
  
  # Add column names
  
  station_names <- gsub("_station.txt", "", files_data)
  
  colnames(q_sim) <- c("Time", station_names)
  
  # Convert to mm/day from m3/s
  
  for (icol in 2:ncol(q_sim)) {
    
    irow = which( paste(metadata$regine_area, ".", metadata$main_no, sep = "") == colnames(q_sim)[icol])
    
    q_sim[,icol] <- (q_sim[,icol] * 1000 * 86400) / (1e6 * metadata$area_total[irow])
    
  }
  
  
  ############# HACK
  
  # Throw out columns missing data
  
  q_sim <- q_sim[, colSums(is.na(q_sim)) != nrow(q_sim)]
  
  ############# HACK
  
  
  return(q_sim)
  
}







