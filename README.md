Runoff data for testing hydrological models at NVE
==================================================

This repository contains runoff data for two periods:

* Period 1 spans from 1975-10-01 to 1995-09-30
* Period 2 spans from 1995-10-01 to 2015-09-30

The stations are used in the flood forecasting service at NVE.

The datasets are stored in the folders /Period1 and /Period2, and the file Metadata.txt contains information about the selected stations.

### Downloading data

Download the data by:

* clicking the 'Clone or download' button and select "Download ZIP"

or:

* clone the repository using `git clone https://github.com/jmgnve/NVE_RUNOFF_TEST_DATA.git`

### Common statistical measures

We use the following measures to judge model performance:

* KGE
* NSE

```R

# Source files

source('utils_eval_models.R')

# Select path and station

path <- "../Period1"
regine_main <- "2.28"

# Load observed runoff

data_obs <- load_qobs(path, regine_main)

# Generate some simulated runoff

data_sim <- data.frame(Time = data_obs$Time, Qsim = data_obs$Qobs * runif(length(data_obs$Qobs), min = 0.8, max = 1.2))

# Compute performance measures

res <- compute_performance(data_sim, data_obs)

# Print results

print(res)

```


### Updating data

The datasets were generated using R code available in the folder /R.
