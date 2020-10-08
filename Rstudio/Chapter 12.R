library(tidyverse)

## CHAPTER 12 EX 

#12.2.1 Exercises:
# Q1

table1
table2
table3
table4a
table4b

# Q2 
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
# Q3
#Recreate the plot showing change in cases over time using table2 instead of table1.

tb2<-table2%>%
  pivot_wider(names_from =type, values_from= count)

ggplot(tb2, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "blue") + 
  geom_point(aes(colour = country))

##12.3.3 Exercises

# Q1

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

stocks %>%
  pivot_wider(names_from = year, values_from = return)%>%
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return",
               names_ptype = list(year = double()))
# Q2
table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")


# Q3
people <- tribble(
  ~name, ~key, ~value,
  #-----------------|--------|------
  "Phillip Woods",  "age", 45,
  "Phillip Woods", "height", 186,
  "Phillip Woods", "age", 50,
  "Jessica Cordero", "age", 37,
  "Jessica Cordero", "height", 156
)
pivot_wider(people, names_from="name", values_from = "value")

people2 <- people %>%
  group_by(name, key) %>%
  mutate(obs = row_number())
view(people2)

# Q4
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)

pregtidy <- preg %>%
  pivot_longer(c(male, female), names_to = "gender", values_to = "count")
pregtidy

##12.4.3 Exercises:

# Q1
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
  separate(x, c("one", "two", "three"), extra = "drop")

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
  separate(x, c("one", "two", "three"), fill = "right")

# Q3
tibble(x = c("X_1", "X_2", "AA_1", "AA_2")) %>%
  separate(x, c("variable", "into"), sep = "_") #separators

tibble(x = c("X1", "X2", "Y1", "Y2")) %>%
  separate(x, c("variable", "into"), sep = c(1))#position

tibble(x = c("X_1", "X_2", "AA_1", "AA_2")) %>%
  extract(x, c("variable", "id"), regex = "([A-Z])_([0-9])")

tibble(variable = c("X", "X", "Y", "Y"), id = c(1, 2, 1, 2)) %>%
  unite(x, variable, id, sep = "_")


