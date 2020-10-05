library(tidyverse)

library(nycflights13)
fly<-flights

#filter Function
filter(flights, month==1, day==1)
FirstOfJan<-filter(flights, month==1, day==1)
(NovToDec<-filter(flights, month==11 | month==12))
(No_dely<-filter(flights, dep_delay==0 & arr_delay==0))
(not_late<-filter(flights, arr_delay==0))

#arragne function
arrange(flights, year,month,day)
arfun<-arrange(flights, year,month,day)
arrange(flights, desc(dep_delay))

#select Function 
select(flights, dep_delay)
M_flights<- flights[starts_with("M",vars =flights$dest),]
R_flights<- flights[starts_with("R",vars =flights$dest),]
select(flights, dep_delay,everything())

#mutate Function 
 
flight_smal<-select(flights,
                    year:day,
                    ends_with("delay"),
                    distance,
                    air_time)

flights_smal_add<-mutate(flight_smal,
                         gain=dep_delay - arr_delay,
                         speed=distance/air_time*60,
                         hours=air_time/60,
                         gain_per_hour=gain/hours)

transmute(flights,
          gain=dep_delay - arr_delay,
          hours=air_time/60,
          gain_per_hour=gain/hours)

#summarise
summarise(flights,delay=mean(dep_delay, na.rm = TRUE))

by_des<-group_by(flights,dest)
delay<-summarise(by_des,
                 count=n(),
                dist=mean(distance, na.rm=TRUE),
                delay=mean(arr_delay, na.rm = TRUE))

delay<- filter(delay,count>20 , dest != "HNL")
ggplot(data=delay,mapping =aes(x=dist , y= delay))+ geom_point(aes(size=count),alpha=1/3)+
  geom_smooth(se= FALSE)



#using pipes %>%
delays<-flights%>%
  group_by(dest)%>%
  summarise( count=n(),
            dist=mean(distance, na.rm=TRUE),
            delay=mean(arr_delay, na.rm = TRUE)
            )%>%
  filter(count>20 , dest != "HNL")
  
#missing value

not_cancelled<- flights%>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled%>%
  group_by(year,month,day)%>%
  summarise(mean=mean(dep_delay))

delays<-not_cancelled%>%
group_by(tailnum)%>%
  summarise(
    delay=mean(arr_delay, na.rm=TRUE),
    n=n()
    )

ggplot(delays , mapping = aes(x=n , y=delay))+
  geom_point(alpha=1/10)  

delays %>%
  filter(n>25)%>%
  ggplot(mapping = aes(x=n , y=delay , size= n))+
  geom_point(alpha =1/10)


