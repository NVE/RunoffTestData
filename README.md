Runoff data for testing hydrological models at NVE
==================================================

This repository contains runoff data for standardized evaluation of hydrological models. We have splitted the data into two periods, one for calibration and the other for validation:

* Period_Calib spans from 1975-10-01 to 1995-09-30
* Period_Valid spans from 1995-10-01 to 2015-09-30

The selected stations are used in the flood forecasting service at NVE.

The datasets are stored in the folders /Period_Calib and /Period_Valid, and the file Metadata.txt contains additional information about the selected stations.

The unit for the runoff data stored in the files is m3/day.

### Downloading data

Download the data by:

* clicking the 'Clone or download' button and select "Download ZIP"

or:

* clone the repository using `git clone https://github.com/jmgnve/NVE_RUNOFF_TEST_DATA.git`

For windows machines, the second method requires an installation of the program 'Github Desktop' available on 'NVE Programvaresenter'. On linux machines, this software should already be available.

### Common statistical measures

We use the following measures for judging model performance:

* KGE
* NSE

The code below computes those measures excluding the first 3 years which are considered as spinup. It uses functions stored in the file R/utils_eval_models.R. Before running the code make sure that the working directory and paths are set correctly.

```R

# Source files

source('utils_eval_models.R')

# Select path and station

path <- "../Period_Valid"
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

The datasets were generated using R function load_runoff_data available in the folder /R.
