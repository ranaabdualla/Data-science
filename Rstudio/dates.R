library(tidyverse)
library(nycflights13)
library(lubridate)

today()
now()

ymd("2020-06-06")
mdy("june 6th, 1997")
dmy("6-jun-1997")

ymd_hms("1997-06-06 10:30:00", tz="EST")

ymd(19970606)


#grab date and time object from individual component 
flights%>%
  select(year,month,day,hour,minute)%>%
mutate(departure=make_datetime(year,month,day,hour,minute))

#convert all time in one pop

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

#visualization of year
flightsdf%>%
  ggplot(aes(dep_time))+
  geom_freqpoly(binwidth=86400)#86400 S = 1day

#visualization of day
 flightsdf%>%
   filter(dep_time<ymd(20130102))%>%
   ggplot(aes(dep_time))+
     geom_freqpoly(binwidth=600) #600 s = 10minutes



#seperate component
 datetime<-ymd_hms("2016-06-06 12:12:33")
 year(datetime)
 month(datetime)
 day(datetime)
 yday(datetime)
wday(datetime, label=TRUE)

flightsdf%>%
  mutate(wday=wday(dep_time, label=TRUE))%>%
ggplot(aes(x=wday))+
  geom_bar()

flightsdf%>%
  mutate(wday=wday(dep_time, label=TRUE))%>%
  filter(wday!="Sun" & wday!= "Sat")%>%
  ggplot(aes(x=wday))+
  geom_bar()

flightsdf%>%
  mutate(dep_hour=update(dep_time, yday=1))%>%
  ggplot(aes(dep_hour))+
  geom_freqpoly(binwidth=300)

#opratins with dates

ddays(1)
datetime<-ymd_hms("2020-01-01 00:00:00")

datetime+dyears(1)
datetime + days(1)
datetime +months(1)
datetime + years(1)

flightsdf%>%
  filter(arr_time< dep_time)

flightsdf<-flightsdf%>%
  mutate(overnight=arr_time< dep_time,
         arr_time=arr_time+days(overnight*1),
         sched_dep_time=sched_arr_time+days(overnight*1)
         )

  
  
