

# Source files

source("R/run_evaluation.R")
source("R/utils_eval.R")
source("R/utils_data.R")


# Describe model

model_name <- "Model name"
model_version <- "0.1"
model_desc <- "The is a toy example"
model_input <- "SeNorge"
model_res <- "Local folder on my computer"


# Path to model results

path_model <- "Example/"


### Run analysis for calibration period ###

period <- "calib"

# Path to simulation results

path_obs <- paste("24h/qobs_", period, sep = "")

path_sim <- paste(path_model, period, "_txt", sep = "")

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

path_sim <- paste(path_model, period, "_txt", sep = "")

# Load observed runoff

q_obs <- load_runoff_obs(path_obs)

# Load simulated runoff

q_sim <- load_vann_res(path_sim)

ikeep <- which(colnames(q_sim) %in% colnames(q_obs))

q_sim <- q_sim[, ikeep]

# Run analysis

run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)



