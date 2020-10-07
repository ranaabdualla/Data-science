library(tidyverse)

x<- c("apple","banana","eggplant")
str_view(x,"a.")

stringr::words

#how many common word start with t ?
sum(str_detect(words,"^t")) #the hat sign ^ means the first letter

words[str_detect(words,"^t")]

Saveb<- words[str_detect(words,"^t")] #if i wanna save it in a vector .


#what proportion common words end with a vowel ?

mean(str_detect(words,"[aeoiu]$"))
sum(str_detect(words,"[aeoiu]$"))

#finds all word contain at least 1 vowel , and negate them 
novowel<- !str_detect(words,"[eaiou]")

sum(novowel)
words[novowel]

#add words to a tibble data frame 
#tibble data frame is easy to manipulate in the tidyvers 

df<- tibble (
  word=words,
  i=seq_along(word)
)
#ues previously known function

df%>%
  filter(str_detect(word,"x$"))  #x$ thats mean its ends with x 

df%>%
  mutate(                                 #mutate is a functio to create a new variahle from the dataset.
    vowel=str_count(word,"[eaiou]"),
    consonant=str_count(word,"[^aeiou]") #it will add to columns and it will shows the number of vowel and consonant for each words
  )

#split strings

sentences

sentences%>%
  head(5)%>%
  str_split(" ", simplify = TRUE)


