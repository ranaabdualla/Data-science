#Issues: Camount of rain? Temperature? 
#NOTE: Not all weather stationan you predict the s started operating since 2000

library(tidyverse)
brazilweather <- read.csv("~/brazil weather.csv")
brazilweather

#its not tidy , beacuse the "datetime" columns, So i have to spreate them .

brazil_weather<-brazilweather%>%
     separate(dateTime, into = c("Date","Time"), sep = " ")

#So now I have 2 columns "data" and I have delete one of them also the other replicated columns,
#such as year , month, day and hour beacuse Idont need them

brazil_weather1<-brazil_weather%>%
  select(Weath_SID, Weath_s_N, elvt , lat ,lon ,
         S_num,city, State, Date , Time , prcp, 
         Air_pressure, pmax , pmin ,Solar_radi,
         Air_temp ,dew_point_temp ,tmax ,dmax,
         tmin, dmin ,Relative_humid, hmax,
         hmin, wind_speed, wind_direction,
         Wind_gus )

View(brazil_weather1)


# as we see now it almost Tidy  "brazil_weather1" ...
#but I would like to spreate it to several tables to make sure its tidy

station_info<-brazil_weather1%>%
  select(Weath_SID, Weath_s_N, elvt,
         lat, lon, S_num, 
         city , State ) # I treid to do a "pivot_wider" on "Weath_s_n" columns to put  station names as columns , but I think is not a great idea.

weather_info<-brazil_weather1%>%
  select(city, Date , Time , prcp, 
         Air_pressure, pmax , pmin ,Solar_radi,
         Air_temp ,dew_point_temp ,tmax ,dmax,
         tmin, dmin ,Relative_humid, hmax,
         hmin, wind_speed, wind_direction,
         Wind_gus ) 

#tables that I have now:

brazil_weather1
station_info
weather_info

## EDA ##

#What type of variation occurs within my variables?
#What type of covariation occurs between my variables?

#start wuth general informatin >>
ggplot(data = brazil_weather1)+ geom_bar(mapping = aes(x= Weath_s_N , color=city)) # here I realized that weather station "BARBACENA" and "araxa" they are active more than the other

#I wo
ggplot(data = station_info)+
  geom_point(mapping = aes(x=city , y =elvt)) 

 ggplot(data = brazil_weather)+
    geom_histogram(mapping = aes(x=wind_speed), binwidth =0.06 )
 
ggplot(data = brazil_weather , mapping = aes(x=wind_speed , color= city))+
    geom_freqpoly(binwidth=0.07)

ggplot(data = weather_info , mapping = aes(x=Air_pressure , y= ..density..))+
  geom_freqpoly(mapping = aes(color= city), binwidth=500)  




station_info%>%
  count(S_num , State )%>%
  ggplot(mapping= aes(x=State , y =S_num))+
  geom_tile(mapping = aes(fill=n)) 


ggplot(data = weather_info)+
  geom_count(mapping = aes(x= city , y=prcp))


ggplot(brazil_weather, aes(year , prcp)) + 
  geom_line(aes(city, colour= city))      #change of precipitation of rain per year 

amount_of_precipitation<-brazil_weather%>% # the amount of the rain per year 
  group_by(year , city) %>%
  filter(!is.na(prcp) , prcp>0 )%>%
  mutate(amount= prcp*100)%>%
  select(year , city , prcp ,amount )

amount_of_precipitation

ggplot(data = amount_of_precipitation , mapping = aes(x=amount , y= ..density..))+
  geom_freqpoly(binwidth=1000)   #amount of rain

rainfall<-brazilweather%>%
  select(city,prcp,year,month,hr,Wind_gus)

summer_rain<-rainfall%>% # the amount of the rain per year 
  filter(!is.na(prcp),month >5 , month<9)%>%
  group_by(city,month)%>%
select(month, prcp , city )
  
 ggplot(summer_rain, aes(month , prcp)) + 
  geom_line(aes(city, colour= month))

