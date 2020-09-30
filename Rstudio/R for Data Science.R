library(tidyverse)
mpg

## SECTION 3.2.4 ##
# 1.Run ggplot(data = mpg). What do you see ?
ggplot(data=mpg) # it shows an Empty graph 

# 2.How many rows are in mpg? How many columns?
nrow(mpg) #234
ncol(mpg) #11

# 3.What does the drv variable describe? Read the help for ?mpg to find out.
?mpg #the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# 4.Make a scatterplot of hwy vs cyl.
ggplot(data=mpg) + geom_point(mapping= aes(x=hwy, y=cyl))


# 5.What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data=mpg) + geom_point(mapping= aes(x=class , y=drv))# drv and class are categorical variables and they  take a small number of values, So thats why they are NOT usful



## SECTION  3.3.1 ##
# 1.What's gone wrong with this code? Why are the points not blue
ggplot(data = mpg) + 
geom_point(mapping = aes(x = displ, y = hwy, color = "blue")) #it won't show color blue cause, it is insaide the mapping so it's treated as aesthetic
#to correct that we should do this:
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 2.Which variables in mpg are categorical? Which variables are continuous?How can you see this information when you run mpg? 
#In the Help section on right side 
?mpg  # I think categorical the variables in mpg they are :manufacturer, model, trans, drv, and class


# 3.Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(mpg, aes(x = displ, y = hwy, color = cyl)) + geom_point() #using Color
ggplot(mpg, aes(x = displ, y = hwy, size = cyl)) +geom_point()   #using size
ggplot(mpg, aes(x = displ, y = hwy, shape = cyl)) +geom_point()  #shape

# 4.What happens if you map the same variable to multiple aesthetics?
ggplot(mpg, aes(x = drv, y = hwy, color = hwy, size = drv)) + geom_point()
  
# 5.What does the stroke aesthetic do? What shapes does it work with? 
?geom_point #Stroke changes the size of the border for shapes, these are filled shapes in which the color and size of the border can differ from that of the filled interior of the shape

# 6.What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)? 
ggplot(mpg, aes(x = displ, y = hwy, colour = displ < 5)) + geom_point() # the (displ < 5) treated as a variable and it takes TRUE or FALSE




## SECTION 3.5.1 ##
# 1.What happens if you facet on a continuous variable?
ggplot(mpg, aes(x = displ, y = hwy)) +geom_point() +
facet_grid(. ~ cyl) #where "cyl" is a continuous variable
# the cyl ??onverted to categorical variable.


# 2.What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
ggplot(data = mpg) + geom_point(mapping = aes(x = hwy, y = cty))
ggplot(data = mpg) + geom_point(mapping = aes(x = hwy, y = cty)) + facet_grid(drv ~ cyl)
#combinations of drv and cyl that have no observations ,the same locations in the scatter plot of drv and cyl that have no points

# 3.What plots does the following code make? What does . do?
  ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)# ignores that dimension when faceting.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)#will facet by values of cyl on the x-axis.


# 4.Take the first faceted plot in this section:
  ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#What are the advantages to using faceting instead of the colour aesthetic? 
#map the COLOR 
ggplot(data = mpg) +
geom_point(mapping = aes(x = displ, y = hwy, color = class))
# a.ability to contain more categories
# b.I think it easy to read 
# c.it can make it easier to compare the shape of the relationship between the x and y 
#What are the disadvantages?
# a.difficul to comparw the values of observations between categories
# b.it visualizes the unconditional relationship between x and y
#How might the balance change if you had a larger dataset?
#  there is often overlap So It is difficult to handle overlapping points with different colors.

# 5.Read ?facet_wrap. 
?facet_wrap()
#What does nrow do? determines the number of rows
#What does ncol do? determines the number of columns
#What other options control the layout of the individual panels? facets,scales,shrink,labeller,as.table,switch,drop,dir and strip.position
#Why doesn't facet_grid() have nrow and ncol arguments? 
 ?facet_grid() #Cause it's not necessary, the number of unique values of the variables specified in the function determines the number of rows and columns.
# 6.When using facet_grid() you should usually put the variable with more unique levels in the columns. Why? 
?facet_grid()  #Cause There will be more space for columns.


## SECTION 3.6.1 ##
# 1.What geom would you use to draw a line chart? 
geom_line()
#A boxplot?
geom_boxplot()
#A histogram?
geom_histogram()
#An area chart?
geom_area()

# 2.Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3.What does show.legend = FALSE do? 
#       hides the legend box 
#What happens if you remove it?
#       setting show.legend = TRUE will result in the plot having a legend displaying the mapping
#Why do you think I used it earlier in the chapter? 
#       adding a legend to only the last plot would make the sizes of plots different. Different sized plots would make it more difficult to see how arguments change the appearance of the plots

# 4.What does the se argument to geom_smooth() do? 
#      It adds standard error bands to the lines

# 5.Will these two graphs look different? Why/why not?
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

  ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#they are the SAME, they use the same data and mappings
  
# 6.Recreate the R code necessary to generate the following graphs.
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth(se = FALSE)
ggplot(mpg, aes(x = displ, y = hwy)) +geom_smooth(mapping = aes(group = drv), se = FALSE) +geom_point()
ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + geom_point() + geom_smooth(se = FALSE)
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(colour = drv)) +geom_smooth(se = FALSE)
ggplot(mpg, aes(x = displ, y = hwy)) +geom_point(size = 4, color = "white") + geom_point(aes(colour = drv))






## SECTION 3.7.1 ##
# 1.What is the default geom associated with stat_summary()? 
geom_pointrange()
#How could you rewrite the previous plot to use that geom function instead of the stat function?
ggplot(data = diamonds) + geom_pointrange( mapping = aes(x = cut, y = depth), stat = "summary")

# 2.What does geom_col() do? How is it different to geom_bar()?
geom_col() #The default stat of geom_col() is stat_identity(), which leaves the data as is, expects that the data contains x values and y values which represent the bar height.
geom_bar() #function only expects an x variable, The y aesthetic uses the values of these counts  

# 3.Most geoms and stats come in pairs that are almost always used in concert. Read through the documentation and make a list of all the pairs. What do they have in common?

#[geom_bar()	stat_count()]                   , [geom_bin2d()	stat_bin_2d()]   ,[geom_boxplot()	stat_boxplot()]
#[geom_contour_filled()	stat_contour_filled()], [geom_contour()	stat_contour()],[geom_count()	stat_sum()]
#[geom_density_2d()	stat_density_2d()]        , [geom_density()	stat_density()],[geom_dotplot()	stat_bindot()]
#[geom_function()	stat_function()]            ,[geom_sf()	stat_sf()]           ,[geom_sf()	stat_sf()]
#[geom_smooth()	stat_smooth()]                ,[geom_violin()	stat_ydensity()] ,[geom_hex()	stat_bin_hex()]
#[geom_qq_line()	stat_qq_line()]             ,[geom_qq()	stat_qq()]           ,[geom_quantile()	stat_quantile()]

# 4.What variables does stat_smooth() compute? What parameters control its behaviour?
?stat_smooth()
#compute: y: predicted value, ymin: lower value of the confidence interval, ymax: upper value of the confidence interval, se: standard error
#parameter: method, formula, method.arg(), se, na.rm, 
# 5.In our proportion bar chart, we need to set group = 1. Why? In other words what is the problem with these two graphs?
#in case the group =1 is not include the, all the bars in the plot will have the same height a height of 1, cause "geom_bar" assumeing that the groups are equal to the x values since the stat computes the counts within the group


######################################################################

##SECTION 3.8.1##

# 1.What is the problem with this plot? How could you improve it?
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() # overplotting
#the Imporvement is:
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_point(position = "jitter")

# 2.What parameters to geom_jitter() control the amount of jittering? width and height



# 3.Compare and contrast geom_jitter() with geom_count().
geom_jitter()#adds random variation to the locations points of the graph and its  method reduces overplotting since two points with the same location are unlikely to have the same random variation.
geom_count() #sizes the points relative to the number of observations
#4.What's the default position adjustment for geom_boxplot()? Create a visualisation of the mpg dataset that demonstrates it.
#the default position adjustment for geom_boxplot() is dodge2
ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) + geom_boxplot()
