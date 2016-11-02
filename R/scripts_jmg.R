
# Run evaluation for vann results

run_eval_vann <- function(path_testdata = "C:/Users/jmg/Dropbox/Work/Rcode/RunoffTestData") {
  
  # Set working directory to correct folder
  
  setwd(path_testdata)
  
  # Libraries
  
  library(tcltk)
  
  # Source files
  
  source("R/run_evaluation.R")
  source("R/utils_eval.R")
  source("R/utils_data.R")
  
  # Path to model results
  
  path_model <- tk_choose.dir(default = "C:/Users/jmg/Dropbox/Work/VannData/")
  
  # Describe model
  
  model_name <- readline("Name of the model? ")
  model_version <- readline("Version of the model? ")
  model_desc <- readline("Additional description? ")
  model_input <- readline("Input data? ")
  model_res <- readline("Path to model results? ")
  
  ### Run analysis for calibration period ###
  
  period <- "calib"
  
  # Path to simulation results
  
  path_obs <- paste("24h/qobs_", period, sep = "")
  
  path_sim <- paste(path_model, "/", period, "_txt", sep = "")
  
  # Load observed runoff
  
  q_obs <- load_runoff_obs(path_obs)
  
  # Load simulated runoff
  
  q_sim <- load_vann_res(path_sim)
  
  ikeep <- which(colnames(q_sim) %in% colnames(q_obs))
  
  q_sim <- q_sim[, ikeep]
  
  # Run analysis
  
  run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)
  
  
  ### Run analysis for validation period ###
  
  period <- "valid"
  
  # Path to simulation results
  
  path_obs <- paste("24h/qobs_", period, sep = "")
  
  path_sim <- paste(path_model, "/", period, "_txt", sep = "")
  
  # Load observed runoff
  
  q_obs <- load_runoff_obs(path_obs)
  
  # Load simulated runoff
  
  q_sim <- load_vann_res(path_sim)
  
  ikeep <- which(colnames(q_sim) %in% colnames(q_obs))
  
  q_sim <- q_sim[, ikeep]
  
  # Run analysis
  
  run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)
  
}



# Plot results from one model run

plot_one_run <- function(path_testdata = "C:/Users/jmg/Dropbox/Work/Rcode/RunoffTestData") {
  
  # Set working directory to correct folder
  
  setwd(path_testdata)
  
  # Libraries
  
  library(tcltk)
  
  # Source files
  
  source("R/utils_plot.R")
  
  # Get paths
  
  model <- tk_choose.files(paste(path_testdata, "/24h/results_calib/", sep = ""), "Choose model")
  
  model <- basename(model)
  
  model <- substring(model, 1 , nchar(model)-4)
  
  path_save <- tk_choose.dir("C:/Users/jmg/Dropbox/Work/VannData/", "Folder for saving data")
  
  
  plot_results(path_testdata, model, path_save)
  
  
}


# Plot results from all model runs

plot_all_runs <- function(path_testdata = "C:/Users/jmg/Dropbox/Work/Rcode/RunoffTestData") {
  
  # Libraries
  
  library(tcltk)
  
  # Source files
  
  source("R/utils_plot.R")
  
  # Get paths
  
  path_save <- tk_choose.dir("C:/Users/jmg/Dropbox/Work/VannData/", "Folder for saving data")
  
  file_save <- readline("Name of the file? ")
  
  plot_boxplots(path_testdata, path_save, file_save)
  
}





























