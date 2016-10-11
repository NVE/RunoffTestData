
# Path to model results

path_model <- "/hdata/fou/jmg/FloodForecasting/Model/txt"

# Source files

source("R/run_evaluation.R")
source("R/utils_eval.R")
source("R/utils_data.R")

# Describe model

model_name <- "Vann"
model_version <- "0.1"
model_desc <- "The is a toy example"

# Load observed runoff

q_obs <- load_runoff_obs(path_obs = "Period_Valid")

# Load simulated runoff

q_sim <- load_vann_res(path_model)

# Run analysis

run_evaluation(q_obs, q_sim, model_name, model_version, model_desc)
