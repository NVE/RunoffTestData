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





