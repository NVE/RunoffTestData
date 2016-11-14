# Clear workspace
setwd('C:/Users/koe/Documents/RunoffTestData')
rm(list=ls())

# Source required functions

source("R/run_evaluation.R")
source("R/utils_eval.R")
source("R/utils_data.R")

# Add information about your model

model_name <- "HBV"
model_version <- "0.1"
model_desc <- "Original version"
model_input <- "SeNorge"
model_res <- "Local folder on my computer"

# Run analysis for calibration period

period <- "calib"

# Path to observation data and simulation results

path_obs <- "24h/qobs_calib"

path_sim <- "../VANN/201611101255_Results/calib_txt"

# Load observed runoff

q_obs <- load_runoff_obs(path_obs)

# Load simulated runoff (only keep those who match observations)

q_sim <- load_vann_res(path_sim)

ikeep <- which(colnames(q_sim) %in% colnames(q_obs))

q_sim <- q_sim[, ikeep]

# Run analysis

run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)



201611110708_Results