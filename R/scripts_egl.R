
##############################################################################################

# Clear workspace

rm(list=ls())

# Source required functions

source("R/run_evaluation.R")
source("R/utils_eval.R")
source("R/utils_data.R")

# Add information about your model

model_name <- "HBV"
model_version <- "operational"
model_desc <- "The is a toy example"
model_input <- "SeNorge"
model_res <- "Local folder on my computer"

# Path to observation data and simulation results

path_sim <- "//hdata/fou/jmg/hbv/"


##############################################################################################

# Run analysis for calibration period

period <- "calib"

path_obs <- "24h/qobs_calib"

# Load observed runoff

q_obs <- load_runoff_obs(path_obs)

# Load simulated runoff (only keep those who match observations)

path_tmp <- file.path(path_sim, paste(period, "_txt", sep = ""), "mmday")

q_sim <- load_hbv_res(path_tmp)

ikeep <- which(colnames(q_sim) %in% colnames(q_obs))

q_sim <- q_sim[, ikeep]

# Run analysis

run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)


##############################################################################################

# Run analysis for calibration period

period <- "valid"

path_obs <- "24h/qobs_valid"

# Load observed runoff

q_obs <- load_runoff_obs(path_obs)

# Load simulated runoff (only keep those who match observations)

path_tmp <- file.path(path_sim, paste(period, "_txt", sep = ""), "mmday")

q_sim <- load_hbv_res(path_tmp)

ikeep <- which(colnames(q_sim) %in% colnames(q_obs))

q_sim <- q_sim[, ikeep]

# Run analysis

run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)


