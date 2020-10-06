library(tidyverse)
## CHAPTER 12 EX ##

table1

table2

table3

table4a

table4b
 
#Extract the number of TB cases per country per year.
#Extract the matching population per country per year.

table2

cases <-table2%>%
  pivot_wider(names_from =type, values_from= count)

table4a

table4b

cas<- table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to="year", values_to="case")

pop<- table4b%>%
  pivot_longer(c(`1999`, `2000`), names_to="year", values_to="population")
   
table4<-left_join(cas,pop)

#Divide cases by population, and multiply by 10000.
rate2<- cases%>%
              mutate(country = country,
                      year = year,
                      rate = cases/populations * 10000)

rate4<- table4%>%
  mutate(country = country,
         year = year,
         rate = case/populations * 10000)

#Recreate the plot showing change in cases over time using table2 instead of table1.

tb2<-table2%>%
  pivot_wider(names_from =type, values_from= count)

ggplot(tb2, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "blue") + 
  geom_point(aes(colour = country))

## CHAPTER 13 ##

library(nycflights13)
