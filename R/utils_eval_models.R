
# Function for loading observed runoff

load_qobs <- function(path, regine_main) {
  
  res <- read.table(file = paste(path, "/", regine_main, ".txt", sep = ""), header = TRUE, sep = "\t")
  
}


# Function for computing performance measures

compute_performance <- function(data_sim, data_obs) {
  
  library(hydroGOF)
  
  stopifnot(all.equal(data_sim$Time, data_obs$Time))
  
  ieval <- 3*365:length(data_sim$Qsim)
  
  KGE <- KGE(data_sim$Qsim[ieval], data_obs$Qobs[ieval], na.rm=TRUE)
  
  NSE <- NSE(data_sim$Qsim[ieval], data_obs$Qobs[ieval], na.rm=TRUE)
  
  res <- list(KGE = KGE, NSE = NSE)
  
}



