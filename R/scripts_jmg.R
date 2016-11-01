# Set working directory to correct folder

setwd("C:/Users/jmg/Dropbox/Work/Rcode/RunoffTestData")

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



