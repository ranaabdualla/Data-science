#EDA
library(tidyverse)

#discret variable
ggplot(data = diamonds)+ geom_bar(mapping = aes(x= cut))

#continous variable

ggplot(data = diamonds)+
geom_histogram(mapping = aes(x=carat), binwidth =0.5 )

smaller<- diamonds%>%
  filter(carat<3)
ggplot(data = smaller , mapping = aes(x=carat))+
  geom_histogram(binwidth = 0.5)

ggplot(data = diamonds , mapping = aes(x=carat , color= cut))+
geom_freqpoly(binwidth=0.1)

ggplot(data = diamonds , mapping = aes(x=carat))+
  geom_histogram(binwidth =0.01)

ggplot(data = diamonds , mapping = aes(x=price , y= ..density..))+
  geom_freqpoly(mapping = aes(color= cut), binwidth=500)

ggplot(data = diamonds , mapping = aes(x=price))+
  geom_freqpoly(mapping = aes(color= cut), binwidth=500)
#box plot

ggplot(data = diamonds , mapping = aes(x=cut, y = price))+
  geom_boxplot()


ggplot(data = diamonds)+
  geom_count(mapping = aes(x= cut , y=color))

diamonds%>%
  count(color , cut )%>%
  ggplot(mapping= aes(x=color , y =cut))+
 geom_tile(mapping = aes(fill=n)) 

ggplot(data = diamonds)+
  geom_point(mapping = aes(x=carat , y =price))

ggplot(data = diamonds)+
  geom_bin2d(mapping = aes(x=carat , y =price))

ggplot(data = smaller)+
  geom_boxplot(mapping = aes(group=cut_width(carat,0.1)))


