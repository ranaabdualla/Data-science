# Heuristic Models (Cost Function Extension)
############################################################
# Look at the seattle weather in the data folder.
# Come up with a heuristic model to predict if
# it will rain today. Keep in mind this is a time series,
# which means that you only know what happened 
# historically (before a given date). One example of a
# heuristic model is: it will rain tomorrow if it rained
# more than 1 inch (>1.0 PRCP) today. Describe your heuristic
# model here

library(tidyverse)
df <- read.csv("https://raw.githubusercontent.com/daniel-dc-cd/data_science/master/module_4_ML/data/seattle_weather_1948-2017.csv")

numrow = 25549

heuristic_df <- data.frame("Yesterday" = 0,
                           "Today" = 0,
                           "Tomorrow" = 0,
                           "Guess" = FALSE,
                           "Rain Tomorrow" = FALSE,
                           "Correct" = FALSE,
                           "True Positive" = FALSE,
                           "False Positive" = FALSE,
                           "True Negative" = FALSE,
                           "False Negative" = FALSE)



df$PRCP = ifelse(is.na(df$PRCP),
                 ave(df$PRCP, FUN = function(x) mean(x, na.rm = TRUE)),
                 df$PRCP)

for (z in 1:numrow){
  i = z + 2
  yesterday = df[i-2,2]
  today = df[i-1,2]
  tomorrow = df[i,2]
  if (tomorrow == 0){
    rain_tomorrow = FALSE
  }else{
    rain_tomorrow = TRUE
  }
  heuristic_df[z,1] = yesterday
  heuristic_df[z,2] = today
  heuristic_df[z,3] = tomorrow
  heuristic_df[z,4] = FALSE # Label all guesses as false
  heuristic_df[z,5] = rain_tomorrow
  heuristic_df[z,7] = FALSE
  heuristic_df[z,8] = FALSE
  heuristic_df[z,9] = FALSE
  heuristic_df[z,10] = FALSE
  
  if ((today > 0) & (yesterday > 0)){
    heuristic_df[z,4] = TRUE
  }
  if (heuristic_df[z,4] == heuristic_df[z,5]){
    heuristic_df[z,6] = TRUE
    if (heuristic_df[z,4] == TRUE){
      heuristic_df[z,7] = TRUE #true positive
    }else{
      heuristic_df[z,9] = TRUE #True negative
    }
  }else{
    heuristic_df[z,6] = FALSE
    if (heuristic_df[z,4] == TRUE){
      heuristic_df[z,7] = TRUE #false positive
    }else{
      heuristic_df[z,9] = TRUE #false negative
    }
  }
}

# Split data into training and testing
## enter split function here to make h_train and h_test subsets of the data
library(caTools) 
split = sample.split(heuristic_df$Rain.Tomorrow , SplitRatio = 0.8)
h_train=subset(heuristic_df , split== TRUE)
h_test=subset(heuristic_df , split== FALSE)



# Calculate the accuracy of your predictions
# we used this simple approach in the first part to see what percent of the time we where correct 
# calculated as (true positive + true negative)/ number of guesses

num_of_guesses<-0
for (i in heuristic_df$Guess){
  num_of_guesses=num_of_guesses+1
  
}

positive<-0

for(i in heuristic_df$True.Positive){
  positive=positive+i  
}

negative<-0

for(i in heuristic_df$True.Negative){
  negative=negative+i  
}

accuracy <- (positive + negative)/num_of_guesses





# Calculate the precision of your prediction
# precision is the percent of your postive prediction which are correct
# more specifically it is calculated (num true positive)/(num tru positive + num false positive)

num_of_TRUEPOSITIVE<-0
for (i in heuristic_df$True.Positive){
  num_of_TRUEPOSITIVE=num_of_TRUEPOSITIVE+1
  
}

num_false_positive<-0
for (i in heuristic_df$False.Positive){
  num_false_positive=num_false_positive+1
  
}


precision_prediction<- num_of_TRUEPOSITIVE/(num_of_TRUEPOSITIVE+num_false_positive)





# Calculate the recall of your predictions
# recall the percent of the time you are correct when you predict positive
# more specifically it is calculated (num true positive)/(num tru positive + num false negative)

num_false_negative<-0

for (i in heuristic_df$False.negative){
  num_false_negative=num_false_negative+1
  
}
recall_of_predictions<-num_of_TRUEPOSITIVE/(num_of_TRUEPOSITIVE+num_false_negative)


# The sum of squared error (SSE) of your predictions

SSE1 <- lm(precision_prediction ~ recall_of_predictions)
sum(residuals(SSE1)^2)

