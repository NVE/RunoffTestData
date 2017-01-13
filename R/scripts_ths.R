
##############################################################################################

# Clear workspace

rm(list=ls())

# Source required functions

source("R/run_evaluation.R")
source("R/utils_eval.R")
source("R/utils_data.R")

# Add information about your model

model_name <- "DDD"
model_version <- "20161202"
model_desc <- "No extra information"
model_input <- "Probably SeNorge v2.0"
model_res <- "//nve/fil/h/HB/HB-modellering/DDDtestbenk/DDD_kalibrering/Jansmaskin/"

# Path to observation data and simulation results

path_sim <- "//nve/fil/h/HB/HB-modellering/DDDtestbenk/DDD_kalibrering/Jansmaskin/"


##############################################################################################

# Run analysis for calibration period

period <- "calib"

path_obs <- "24h/qobs_calib"

# Load observed runoff

q_obs <- load_runoff_obs(path_obs)

# Load simulated runoff (only keep those who match observations)

path_tmp <- file.path(path_sim, period)

q_sim <- load_ddd_res(path_tmp)

ikeep <- which(colnames(q_obs) %in% colnames(q_sim))

q_obs <- q_obs[, ikeep]

# Run analysis

run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)


##############################################################################################

# Run analysis for calibration period

period <- "valid"

path_obs <- "24h/qobs_valid"

# Load observed runoff

q_obs <- load_runoff_obs(path_obs)

# Load simulated runoff (only keep those who match observations)

path_tmp <- file.path(path_sim, period)

q_sim <- load_ddd_res(path_tmp)

ikeep <- which(colnames(q_obs) %in% colnames(q_sim))

q_obs <- q_obs[, ikeep]

# Run analysis

run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)


