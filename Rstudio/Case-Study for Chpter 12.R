## Case study in chapter 12 ##

tidyr::who 

who

who1 <- who %>% 
  pivot_longer(
    cols = new_sp_m014:newrel_f65, 
    names_to = "key", 
    values_to = "cases", 
    values_drop_na = TRUE
  )
who1

who1 %>% 
  count(key)

who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

who3 %>% 
  count(new)

who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5


who %>%
  pivot_longer(
    cols = new_sp_m014:newrel_f65, 
    names_to = "key", 
    values_to = "cases", 
    values_drop_na = TRUE
  ) %>% 
  mutate(
    key = stringr::str_replace(key, "newrel", "new_rel")
  ) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

## mssing values##

who1 %>%
  filter(cases == 0) %>%
  nrow()    #checking for the presence of zeros in the data

pivot_longer(who, c(new_sp_m014:newrel_f65), names_to = "key", values_to = "cases") %>%
  group_by(country, year) %>%
  mutate(missing = sum(is.na(cases)) / n()) %>%
  filter(missing > 0, missing < 1)   #checking if all values for country, year are missing

nrow(who)
who %>% 
  complete(country, year) %>%
  nrow()  #check for implicit missing values

anti_join(complete(who, country, year), who, by = c("country", "year")) %>% 
  select(country, year) %>% 
  group_by(country) %>% 
  summarise(min_year = min(year), max_year = max(year)) # what those implicit missing values are ?


