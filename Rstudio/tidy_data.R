library(tidyverse)

# which of these is tidy
table1

table2

table3

table4a

table4b

table5

#tidying when a cloumns name is a value of variable


tidy4a<- table4a %>%
 pivot_longer(c(`1999`, `2000`), names_to="year", values_to="case")

tidy4b<- table4b%>%
  pivot_longer(c(`1999`, `2000`), names_to="year", values_to="population")

left_join(tidy4a,tidy4b)

#observation are accross multiple rows
table2

tidy2<- table2%>%
  pivot_wider(names_from =type, values_from= count)

#multiple vaule i  the same cell

table3

tidy3<- table3%>%
  
  separate(rate, into = c("cases","populations"), sep = "/")
  
