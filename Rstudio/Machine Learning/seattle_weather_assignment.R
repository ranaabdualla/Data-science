# Heuristic Models
# Look at the Seattle weather in the data folder. 
# Come up with a heuristic model to predict if it will rain today. 
# Keep in mind this is a time series, which means that you only know what happened historically (before a given date). 
# One example of a heuristic model is: It will rain tomorrow if it rained more than 1 inch (>1.0 PRCP) today. 
# Describe your heuristic model in the next cell.

# Your model here:

library(tidyverse)
df <- read.csv("https://raw.githubusercontent.com/daniel-dc-cd/data_science/master/module_4_ML/data/seattle_weather_1948-2017.csv")
df[is.na(df)]<-0

heuristic_df<-data.frame(matrix(, nrow=nrow(df)-2, ncol=0))
heuristic_df$Yesterday<-0
heuristic_df$Today<-0
heuristic_df$Tomorrow<-0
heuristic_df$Guess<-FALSE
heuristic_df$Rain_tomorrow<-FALSE
heuristic_df$Correct<-FALSE

head(df, 10)
head(heuristic_df, 10)

for(z in seq(1,nrow(df)-2,1)) {
  i <- z + 2
  yesterday <- df[(i-2),2]
  today <- df[(i-1),2]
  tomorrow <- df[i,2]
  rain_tomorrow <- tomorrow>0
  
  heuristic_df[z,1] <- yesterday
  heuristic_df[z,2] <- today
  heuristic_df[z,3] <- tomorrow
  heuristic_df[z,4] <- FALSE 
  heuristic_df[z,5] <- rain_tomorrow
  
  
  if(heuristic_df[z,2] >0 & heuristic_df[z,1] > 0){
    heuristic_df[z,4] <- TRUE
  }
  
  if(heuristic_df[z,4] == heuristic_df[z,5])  heuristic_df[z,6] <- TRUE
  else heuristic_df[z,6] <- FALSE
}


prediction1=sum(heuristic_df$Correct)/nrow(heuristic_df)
cat(prediction1*100 , "%")
