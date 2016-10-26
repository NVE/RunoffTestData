Runoff data for testing hydrological models at NVE
==================================================

This repository contains:

* Runoff data for standardized evaluation of hydrological models (see folders [/24h/qobs_calib](https://github.com/NVE/RunoffTestData/tree/master/24h/qobs_calib) and [/24h/qobs_valid](https://github.com/NVE/RunoffTestData/tree/master/24h/qobs_valid))
* Functions for computing model performance metrics (see folder [/R](https://github.com/NVE/RunoffTestData/tree/master/R))
* Summary results for different models (see folders [/24h/results_calib](https://github.com/NVE/RunoffTestData/tree/master/24h/results_calib) and [/24h/results_valid](https://github.com/NVE/RunoffTestData/tree/master/24h/results_valid))

New model versions can be tested as described below (see also example model output data and analysis script in this folder [/Example](https://github.com/NVE/RunoffTestData/tree/master/Example)).

The figures in this [link](https://github.com/NVE/RunoffTestData/blob/master/Example_Result.pdf) shows an example of how we can evaluate the results stored in this repository (the function for generating those plots are in the /R folder).

### Downloading data

For downloading the data and code, clone this repository:

`git clone https://github.com/NVE/RunoffTestData.git`

### 24h test dataset

We have splitted the runoff data into two periods, one for calibration and the other for validation:

* The calibration period spans from 2000-09-01 to 2014-12-31
* The validation period spans from 1985-09-01 to 2000-08-31

The selected stations are used in the flood forecasting service at NVE.

The datasets are stored in the folders mentioned above, and the file Metadata.txt contains additional information about the selected stations.

The unit for the runoff data stored in the files is *mm/day*.

### Run analysis for one model (24h dataset)

We compute a standard set of measures for model performance and diagnositics using the following procedure in R. The results are stored in the directories [/24h/results_calib](https://github.com/NVE/RunoffTestData/tree/master/24h/results_calib) and [/24h/results_valid](https://github.com/NVE/RunoffTestData/tree/master/24h/results_valid) and file names are defined by the name and version of the model.

1) Set working directory and source required functions:

Set the working directory to the folder RunoffTestData.

```R
source("R/run_evaluation.R")
source("R/utils_eval.R")
source("R/utils_data.R")
```

2) Add information about your model:

```R
model_name <- "model_name"
model_version <- "0.1"
model_desc <- "The is a toy example"
model_input <- "SeNorge"
model_res <- "Local folder on my computer"
```

3) Run the analysis for the calibration period:

If you want to run the evaluation for the validation period, set period = "valid".

```R
period <- "calib"
```

4) Define paths to observation data and simulation results:

```R
path_obs <- "24h/qobs_calib"
path_sim <- "Example/calib_txt"
```

5) Load observed runoff:

```R
q_obs <- load_runoff_obs(path_obs)
```

6) Load simulated runoff (only keep those stations that match available observations):

Create appropriate methods for loading data from your model and add to file R/utils_data.R and update this github repository.

```R
q_sim <- load_vann_res(path_sim)
ikeep <- which(colnames(q_sim) %in% colnames(q_obs))
q_sim <- q_sim[, ikeep]
```

7) Run model analysis:

This step will save a file with the results in the folder [/24h/results_calib](https://github.com/NVE/RunoffTestData/tree/master/24h/results_calib). Repeat steps 3 to 7 for the validation period. Update this github repository when finished.

```R
run_evaluation(q_obs, q_sim, model_name, model_version, model_desc, model_input, model_res, period)
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

The runoff datasets were generated using R function prepare_runoff_data available in the folder */R*.

### Links to model input data

Input data with 24h time step:

\\nve\fil\h\HB\HB-modellering\DDDtestbenk\DDD2015\inndata

Input data with 3h time step:

\\nve\fil\h\HB\HB-modellering\DDD3h\inndataV2


