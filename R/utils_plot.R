

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


# Plot evaluation for all models
#
# Required inputs:
#
# path_testdata - Path to model results
# path_save - Name of folder to store the results
# file_save - Name of the file

plot_boxplots <- function(path_testdata, path_save, file_save) {
  
  # Set working directory to correct folder
  
  setwd(path_testdata)
  
  # Libraries
  
  library(ggplot2)
  library(tcltk)
  
  # Function for loading all data
  
  read_data <- function(path_data, files_data) {
    
    # files_data <- list.files(path_data)
    
    # files_data <- tk_choose.files(path_data)
    
    df_all <- c()
    
    for (file in files_data) {
      
      df_tmp <- read.table(file.path(path_data, basename(file)), header = TRUE, skip = 10)
      
      df_tmp$Model <- substr(basename(file), 1, nchar(file)-4)
      
      df_all <- rbind(df_all, df_tmp)
      
    }
    
    return(df_all)
    
  }
  
  # Function for plotting all data
  
  plot_all <- function(df_all, plot_title) {
    
    # Plot KGE2009
    
    a <- ggplot(data = df_all, aes(x = Model, y = KGE2009))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    # a <- a + ylim(min(min(df_all$KGE2009)-0.1, 0), 1.1)
    
    a <- a + ylim(0, 1.02)
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot KGE2012
    
    a <- ggplot(data = df_all, aes(x = Model, y = KGE2012))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    # a <- a + ylim(min(min(df_all$KGE2012)-0.1, 0), 1.1)
    
    a <- a + ylim(0, 1.02)
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot r
    
    a <- ggplot(data = df_all, aes(x = Model, y = r))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    a <- a + ylim(0, 1.02)
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot Alpha
    
    a <- ggplot(data = df_all, aes(x = Model, y = Alpha))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot Beta
    
    a <- ggplot(data = df_all, aes(x = Model, y = Beta))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot Gamma
    
    a <- ggplot(data = df_all, aes(x = Model, y = Gamma))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot NSE
    
    a <- ggplot(data = df_all, aes(x = Model, y = NSE))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    # a <- a + ylim(min(min(df_all$NSE)-0.1, 0), 1.1)
    
    a <- a + ylim(0, 1.02)
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot NSE_bench
    
    a <- ggplot(data = df_all, aes(x = Model, y = NSE_bench))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    # a <- a + ylim(min(min(df_all$NSE_bench)-0.1, 0), 1.1)
    
    a <- a + ylim(0, 1.02)
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot Intercept
    
    a <- ggplot(data = df_all, aes(x = Model, y = Intercept))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot Slope
    
    a <- ggplot(data = df_all, aes(x = Model, y = Slope))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot r2
    
    a <- ggplot(data = df_all, aes(x = Model, y = r2))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
    # Plot Pbias
    
    a <- ggplot(data = df_all, aes(x = Model, y = Pbias))
    
    a <- a + geom_boxplot(outlier.colour = "red", fill = "white", colour = "blue")
    
    a <- a + ggtitle(plot_title)
    
    print(a)
    
  }
  
  # Save all plots to one pdf
  
  pdf(file.path(path_save, paste(file_save, ".pdf", sep = "")), width=10, height=6, paper='special') 
  
  # Plot results for calibration period
  
  plot_title <- "Calibration period"
  
  path_calib <- "24h/results_calib"
  
  files_data <- tk_choose.files(path_calib)
  
  df_all <- read_data(path_calib, files_data)
  
  plot_all(df_all, plot_title)
  
  # Plot results for validation period
  
  plot_title <- "Validation period"
  
  path_valid <- "24h/results_valid"
  
  df_all <- read_data(path_valid, files_data)
  
  plot_all(df_all, plot_title)
  
  dev.off()
  
}


