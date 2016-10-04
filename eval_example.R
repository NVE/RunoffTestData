# Clear workspace

rm(list=ls())

# Filename for saving the evaluation results

model_name <- "hbv"
model_version <- "0.1"
model_desc <- "The is a toy example"

# Source required functions

source("R/run_evaluation.R")
source("R/utils_eval.R")
source("R/utils_data.R")

# Load observed runoff

q_obs <- load_runoff_obs()

# Generate some simulated runoff

q_sim <- q_obs

rnumbers <- matrix(runif(length(q_sim[,2:ncol(q_sim)]), min = 0.8, max = 1.2), nrow(q_sim), ncol(q_sim)-1)

q_sim[,2:ncol(q_sim)] <- q_sim[,2:ncol(q_sim)] * rnumbers

# Compute performance measures

run_evaluation(q_obs, q_sim, model_name, model_version, model_desc)






