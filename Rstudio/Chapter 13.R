## CHAPTER 13 ##
library(nycflights13)

#	13.2.1 Exercises:
# Q1
flightsLines <- flights %>%
  inner_join(select(airports, origin = faa, origin_lat = lat, origin_lon = lon),
             by = "origin"
  ) %>%
  inner_join(select(airports, dest = faa, dest_lat = lat, dest_lon = lon),
             by = "dest"
  )
flightsLines %>%
  slice(1:100) %>%
  ggplot(aes(
    x = origin_lon, xend = dest_lon,
    y = origin_lat, yend = dest_lat
  )) +
  borders("state") +
  geom_segment(arrow = arrow(length = unit(0.1, "cm"))) +
  coord_quickmap() +
  labs(y = "Latitude", x = "Longitude") #draw Flights Line 

#13.3.1 Exercises:
# Q1

flights%>%
  arrange(year, month, day, sched_dep_time, carrier, flight) %>%
  mutate(flightID = row_number()) %>%
  glimpse()
# Q2

Lahman::Batting
Lahman::Batting %>%
  count(playerID, yearID, stint) %>%
  filter(n > 1) %>%
  nrow()

babynames::babynames %>%
  count(year, sex, name) %>%
  filter(n > 1) %>%
  nrow()

nasaweather::atmos %>%
  count(lat, long, year, month) %>%
  filter(n > 1) %>%
  nrow()

fueleconomy::vehicles %>%
  count(id) %>%
  filter(n > 1) %>%
  nrow()

ggplot2::diamonds %>%
  distinct() %>%
  nrow()

#13.4.6 Exercises:
# Q1

airports%>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

destdelay_avg<-
  flights %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c(dest = "faa"))
destdelay_avg %>%
  ggplot(aes(lon, lat, colour = delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# Q2
airportloc<- airports %>%
  select(faa, lat, lon)  

flights %>%
  select(year:day, hour, origin, dest) %>%
  left_join(
    airportloc,
    by = c("origin" = "faa")
  ) %>%
  left_join(
    airportloc,
    by = c("dest" = "faa")
  )

# Q3
age_delay <- inner_join(flights,                            # I joined the flights and plane, thats would help me to compare them
                            select(planes, tailnum, plane_year = year),
                            by = "tailnum"
) %>%
  mutate(age = year - plane_year) %>%   
  filter(!is.na(age)) %>%
  mutate(age = if_else(age > 25, 25L, age)) %>%  # few planes older than 25 years,  I reduce age at 25 years.
  group_by(age) %>%
  summarise(
    dep_delay_mean = mean(dep_delay, na.rm = TRUE),
    dep_delay_sd = sd(dep_delay, na.rm = TRUE),
    arr_delay_mean = mean(arr_delay, na.rm = TRUE),
    arr_delay_sd = sd(arr_delay, na.rm = TRUE),
    n_arr_delay = sum(!is.na(arr_delay)),
    n_dep_delay = sum(!is.na(dep_delay))
  )

ggplot(age_delay, aes(x = age, y = dep_delay_mean)) +
  geom_point() +
  scale_x_continuous("Age of plane", breaks = seq(0, 30, by = 10)) +
  scale_y_continuous("avg Departure Delay (minutes)")

# Q4
delays_by_weather <-
  flights %>%
  inner_join(weather, by = c(
    "origin" = "origin",
    "year" = "year",
    "month" = "month",
    "day" = "day",
    "hour" = "hour"
  ))
delays_by_weather %>%
  group_by(precip) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = precip, y = delay)) +
  geom_line() + geom_point()

# Q5
flights %>%
  filter(year == 2013, month == 6, day == 13) %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>%
  ggplot(aes(y = lat, x = lon, size = delay, colour = delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

#13.5.1 Exercises:

# Q1
flights %>%
  filter(is.na(tailnum), !is.na(arr_time)) %>%
  nrow()

flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(carrier, sort = TRUE) %>%
  mutate(p = n / sum(n))

# Q2
planes_flown_100 <- flights %>%
  filter(!is.na(tailnum)) %>%
  group_by(tailnum) %>%
  count() %>%
  filter(n >= 100)
flights %>%
  semi_join(planes_flown_100, by = "tailnum")

# Q3

fueleconomy::vehicles %>%
  semi_join(fueleconomy::common, by = c("make", "model"))
fueleconomy::vehicles %>%
  distinct(model, make) %>%
  group_by(model) %>%
  filter(n() > 1) %>%
  arrange(model)
fueleconomy::common %>%
  distinct(model, make) %>%
  group_by(model) %>%
  filter(n() > 1) %>%
  arrange(model)
# Q4
worst_delay <- flights %>%
  mutate(hour = sched_dep_time %/% 100) %>%
  group_by(origin, year, month, day, hour) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(dep_delay)) %>%
  slice(1:48)

worest_delay_by_weather<- semi_join(weather, 
                                    worst_delay, 
                                  by = c("origin", "year",
                                         "month", "day", "hour"))

select(worest_delay_by_weather, temp, wind_speed, precip) %>%
  print(n = 48)

ggplot(worest_delay_by_weather, aes(x = precip, y = wind_speed, color = temp)) +
  geom_point()

# Q5
anti_join(flights, airports, by = c("dest" = "faa")) %>% 
  distinct(dest)

anti_join(airports, flights, by = c("faa" = "dest"))

  # Q6
  planes_carr<-
  flights %>%
  filter(!is.na(tailnum)) %>%
  distinct(tailnum, carrier)

  planes_carr %>%
    count(tailnum) %>%
    filter(n > 1) %>%
    nrow()

  carrier_tran  <- planes_carr %>%
    group_by(tailnum) %>%
    filter(n() > 1) %>%
    left_join(airlines, by = "carrier") %>%
    arrange(tailnum, carrier)  
  carrier_tran
  