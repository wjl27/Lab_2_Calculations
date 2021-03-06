# Grain Size with Confidence Interval

rm(list=ls()) # removes any objects from the enviornment

library(tidyverse) # this package makes it easier to work with datasets

dat <- as_tibble(read.csv("Lab2_Data.csv")) # reads data from .csv file into a tibble, or data frame

cleanDat <- dat %>% filter(Line.Length > 0) %>% # filters out rows with no data for the grain size
                    mutate(Grain.Size = Line.Length / Point.Count) %>% # Creates new column for avg grain size in each sample
                    select(1,6) # selects only the index number column and grain size column

N <- 64 # Number of Samples

nu <- N-1 # degrees of freedom

x_bar <- (1/N)*sum(cleanDat$Grain.Size) # this is the mean grain size in our samples

s_x2 <- (1/nu)*sum((cleanDat$Grain.Size - x_bar)^2) # this is the sample variance of the data set

s_x <- sqrt(s_x2) # this is the standard deviation of the data set

s_x_bar <- s_x/sqrt(N) # This is the standard error in the data set

t_95 <- 1.998 # t value for 63 degrees of freedom at a 95% confidence interval

c_intv <- t_95 * s_x_bar # the confidence interval for the population mean

x_prime <- tibble(x_bar,c_intv)

print(x_prime) # this tibble shows us a range for the mean in which the grain size falls with 95 % confidence
