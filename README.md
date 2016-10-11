Runoff data for testing hydrological models at NVE
==================================================

This repository contains (a) runoff data for standardized evaluation of hydrological models and (b) functions for computing metrics for model performance as well as measures useful for diagnosing simulation results.

We have splitted the data into two periods, one for calibration and the other for validation:

* Period_Calib spans from 1975-10-01 to 1995-09-30
* Period_Valid spans from 1995-10-01 to 2015-09-30

The selected stations are used in the flood forecasting service at NVE.

The datasets are stored in the folders *Period_Calib* and *Period_Valid*, and the file Metadata.txt contains additional information about the selected stations.

The unit for the runoff data stored in the files is *mm/day*.

### Downloading data

For downloading the data and code, clone this repository:

`git clone https://github.com/jmgnve/NVE_RUNOFF_TEST_DATA.git`

### Run analysis for one model

We compute a standard set of measures for model performance and diagnositics using the following procedure in R. The results are stored in the directory *Results* and file names are defined by the name and version of the model.

1) Set working directory and source required functions:

Set the working directory to the folder NVE_RUNOFF_TEST_DATA.

```R
source("R/run_evaluation.R")
source("R/utils_eval.R")
source("R/utils_data.R")
```

2) Add information about the name and version of the model, and also a short description of the simulations.

```R
model_name <- "hbv"
model_version <- "0.1"
model_desc <- "The is a toy example"
```

3) Load observed runoff (stored in folder *Period_Valid*):

```R
q_obs <- load_runoff_obs()
```

4) Load simulated runoff (here we only generate some toy data):

Create appropriate methods for loading data for your model and add to file R/utils_data.R and update this github repository.

```R
q_sim <- q_obs
rnumbers <- matrix(runif(length(q_sim[,2:ncol(q_sim)]), min = 0.8, max = 1.2), nrow(q_sim), ncol(q_sim)-1)
q_sim[,2:ncol(q_sim)] <- q_sim[,2:ncol(q_sim)] * rnumbers
```

5) Run model analysis:

This step will save a file with the results in the folder *Results*. Update this github repository when finished.

```R
run_evaluation(q_obs, q_sim, model_name, model_version, model_desc)
```

### Common statistical measures

We use the following measures for judging model performance:

* KGE - Kling Gupta efficiency
* NSE - Nash Sutcliffe efficiency
* NSE_bench - Nash Sutcliffe efficiency with baseline model defined by average discharge for every calender month
* Intercept - Intercept of linear regression line
* Slope - Slope of linear regression line
* r2 - Squared correlation coefficient
* Bias - Mean error between simulation and observation
* Pbias - Bias in percent between simulation an observation

When computing those measures we exclude the first 3 years which are considered as spinup.

Additions to those metrics can be added to the files R/run_evaluation.R and R/utils_eval.R. Please update this github repository afterwards.

### Updating data

The datasets in *Period_Calib* and *Period_Valid* were generated using R function prepare_runoff_data available in the folder *R*.
