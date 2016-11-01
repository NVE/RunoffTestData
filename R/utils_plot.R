

# Plot evaluation for one model
#
# Required inputs:
#
# path_testdata - Path to model results
# model - Name and version of model (see files in folders /24h/results_calib and /24h/results_valid)
# path_save - name of folder to store the results

plot_results <- function(path_testdata, model, path_save) {
  
  # Libraries
  
  library(ggplot2)
  
  # Load data into data frame
  
  df_calib <- read.table(paste(path_testdata, "/24h/results_calib/", model, ".txt", sep = ""), skip = 10, header = TRUE)
  df_valid <- read.table(paste(path_testdata, "/24h/results_valid/", model, ".txt", sep = ""), skip = 10, header = TRUE)
  
  df_calib$period <- "calib"
  df_valid$period <- "valid"
  
  df <- rbind(df_calib, df_valid)
  
  df$period <- as.factor(df$period)
  
  # Save all plots to one pdf
  
  pdf(paste(path_save, "/", model, ".pdf", sep = ""), width=10, height=6, paper='special') 
  
  # Plot KGE
  
  p <- ggplot(df, aes(KGE, colour = period)) 
  p <- p + stat_ecdf()
  p <- p + theme_gray(base_size = 14, base_family = "")
  p <- p + labs(y = 'Cumulative frequency')
  p <- p + labs(title = "KGE")
  p <- p + xlim(0, 1)
  
  print(p)
  
  # Plot NSE
  
  p <- ggplot(df, aes(NSE, colour = period)) 
  p <- p + stat_ecdf()
  p <- p + theme_gray(base_size = 14, base_family = "")
  p <- p + labs(y = 'Cumulative frequency')
  p <- p + labs(title = "NSE")
  p <- p + xlim(0, 1)
  
  print(p)
  
  # Plot NSE_bench
  
  p <- ggplot(df, aes(NSE_bench, colour = period)) 
  p <- p + stat_ecdf()
  p <- p + theme_gray(base_size = 14, base_family = "")
  p <- p + labs(y = 'Cumulative frequency')
  p <- p + labs(title = "NSE_bench")
  p <- p + xlim(0, 1)
  
  print(p)
  
  # Plot Intercept
  
  p <- ggplot(df, aes(Intercept, colour = period)) 
  p <- p + stat_ecdf()
  p <- p + theme_gray(base_size = 14, base_family = "")
  p <- p + labs(y = 'Cumulative frequency')
  p <- p + labs(title = "Intercept")
  p <- p + xlim(-1.5, 1.5)
  p <- p + geom_vline(xintercept = 0)
  
  print(p)
  
  # Slope
  
  p <- ggplot(df, aes(Slope, colour = period)) 
  p <- p + stat_ecdf()
  p <- p + theme_gray(base_size = 14, base_family = "")
  p <- p + labs(y = 'Cumulative frequency')
  p <- p + labs(title = "Slope")
  p <- p + xlim(0, 2)
  p <- p + geom_vline(xintercept = 1)
  
  print(p)
  
  # Square correlation coefficient
  
  p <- ggplot(df, aes(r2, colour = period)) 
  p <- p + stat_ecdf()
  p <- p + theme_gray(base_size = 14, base_family = "")
  p <- p + labs(y = 'Cumulative frequency')
  p <- p + labs(title = "Square correlation coefficient")
  p <- p + xlim(-1, 1)
  
  print(p)
  
  # Percent bias
  
  p <- ggplot(df, aes(Pbias, colour = period)) 
  p <- p + geom_freqpoly(binwidth = 5)
  p <- p + theme_gray(base_size = 14, base_family = "")
  p <- p + labs(y = 'Frequency')
  p <- p + labs(title = "Percent bias")
  p <- p + xlim(-100, 100)
  
  print(p)
  
  dev.off()
  
}