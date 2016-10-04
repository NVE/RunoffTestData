
# Compute NSE_bench
#
# NSE with a baseline model given by the mean value for every calendar month 
# instead of the mean value for the complete observation times series

NSE_bench <- function(time, q_sim, q_obs) {
  
  # Required libraries
  
  require(lubridate)
  
  # Compute benchmark model (mean value for every calendar month)
  
  time_month <- month(time)
  
  q_bench <- rep(NA, length(time))
  
  for (month_cal in 1:12) {
    imonth <- time_month == month_cal
    q_bench[imonth] <- mean(q_obs[imonth], na.rm = TRUE)
  }
  
  NSE_bench <- 1 - sum( (q_obs - q_sim)^2, na.rm = TRUE ) / sum( (q_obs - q_bench)^2, na.rm = TRUE )
  
  return(NSE_bench)
  
}













