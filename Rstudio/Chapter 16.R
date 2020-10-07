library(tidyverse)
library(nycflights13)
library(lubridate)


#16.2.4 Exercises
# Q1
ymd(c("2010-10-10", "bananas"))
# Q3
d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14"


# 16.3.4 Exercises

flights
#fix the mistake in the date and time 
make_datetime_100<-function(year,month,day,time){
  make_datetime(year,month,day,time%/%100,time%%100)
}

flightsdf<-flights%>%
  filter(!is.na(dep_time), !is.na(arr_time))%>%
  mutate(
    dep_time= make_datetime_100(year,month,day,dep_time),
    arr_time= make_datetime_100(year,month,day,arr_time),
    sched_dep_time=make_datetime_100(year,month,day,sched_dep_time),
    sched_arr_time=make_datetime_100(year,month,day,sched_arr_time)
  )%>%
  select(origin,dest,ends_with("delay"),ends_with("time"))
view(flightsdf)

# Q1
#How does the distribution of flight times within a day change over the course of the year?
     ##by moth##
flightsdf %>%
  filter(!is.na(dep_time)) %>%
  mutate(dep_hour = update(dep_time, yday = 1))%>%
  mutate(month = factor(month(dep_time))) %>%
  ggplot(aes(dep_hour, color = month)) +
  geom_freqpoly(binwidth = 4000)
    ##by day##

flightsdf %>%
  filter(!is.na(dep_time)) %>%
  mutate(dep_hour = update(dep_time, yday = 1))%>%
  mutate(month = factor(month(dep_time)))%>%
  ggplot(aes(dep_hour, color = month)) +
  geom_freqpoly(aes(y = ..density..), binwidth =4000)

#Q 2 :: calculate the actual depatual time .
#
flightsdf %>%
  
  mutate(Actual_dep_time  = sched_dep_time + dep_delay*60) %>%
  filter(Actual_dep_time != dep_time) %>%
  head(5)%>%
  select(Actual_dep_time, dep_time, sched_dep_time, dep_delay)
# to fix the porblem I mad a function called "make_datetime_100" in line 8

# Q3
flightsdf%>%
  mutate(
    fl_dur = as.numeric(arr_time - dep_time), #calculate the flight duration
    air_time1 = air_time,
    diffrence = fl_dur - air_time1         # calculate the diffirence between them 
  ) %>%
  select(origin, dest, fl_dur, air_time1, diffrence)

#Q 4 :: 	How does the average delay time change over the course of a day? 
flightsdf %>%
  mutate(sched_dep_hour = hour(sched_dep_time)) %>%
        group_by(sched_dep_hour) %>%
        summarise(dep_delay = mean(dep_delay)) %>%
        ggplot(aes(y = dep_delay, x = sched_dep_hour)) +
        geom_point() +
        geom_smooth()

#Q 5 :: 5.	On what day of the week should you leave if you want to minimise the chance of a delay 
flightsdf %>%
  mutate(day_over_week = wday(sched_dep_time)) %>%
  group_by(day_over_week) %>%
  summarise(
    dep_delay = mean(dep_delay),
    arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
 select(day_over_week,dep_delay,arr_delay)


flightsdf%>%
  mutate(wday = wday(dep_time, label = TRUE)) %>% 
  group_by(wday) %>% 
  summarize(ave_dep_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(x = wday, y = ave_dep_delay)) + 
  geom_bar(stat = "identity")


#Q6 
ggplot(diamonds, aes(x = carat)) +
  geom_freqpoly()

ggplot(diamonds, aes(x = carat %% 1 * 100)) +
  geom_histogram(binwidth = 5)

ggplot(flightsdf, aes(x = minute(sched_dep_time))) +
  geom_histogram(binwidth = 5)

# Q7

flightsdf %>% 
  mutate(minute = minute(dep_time),
         no_delay = dep_delay < 0) %>% 
  group_by(minute) %>% 
  summarise(
    no_delay  = mean(no_delay, na.rm = TRUE),
    n = n())%>% 
  ggplot(aes(minute, no_delay))+
  geom_line()

## 16.4.5 Exercises

# Q3
#Create a vector of dates giving the first day of every month in 2015.
ymd("2015-01-01") + months(0:11)

#Create a vector of dates giving the first day of every month in the current year.
floor_date(today(), unit = "year") + months(0:11)

#Q4
myage<- function(bday) {
  (bday %--% today()) %/% years(1)
  }
myage(ymd("1999-10-23"))



  