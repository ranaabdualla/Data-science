#1.new drink "Barrel-Aged Dantzig"
#2.with  margin of $30
#3.uses 10 pounds of corn , 4 oz of hops, 5 pounds of malt ,
#4.LP Brewery has to now think about allocating its personnel to the different manufacturing processes.
#5.Each of the kegs takes 5 (Hopatronic), 10 (All American), and 20 (Dantzig)
#6.we have only 5 employees full-time
#7.If this is the production planning for a month of brewing, 
#5.what is the optimal amount of each beer that must be produced to maximize profit ???

library(lpSolve)

f.obj <- c(13,23,30) #profit for the tow beers , and I add the 30 for the new  

f.con <- matrix(c(5,15,10,
                  4,4,4,
                  35,20,5), nrow = 3, byrow = TRUE) #corn , 4 oz of hops, 5 pounds of malt , here I also add 10 , 4 and 5 for the corn, hat and malt

f.dir <- c("<=",
           "<=",
           "<=")


f.rhs <- c(480,
           800,
           1190) #total amount 
 

sol<-lp("max", f.obj, f.con, f.dir, f.rhs, compute.sens = TRUE)
sol$objval #the maximum value 
sol$solution 
sol$duals    #optimization problems 

##  the profit ##

#before we add the NEW drink we have a 800 for the maximum value
#12 , 28 for the solution  and 12000 for the duals 


## after adding new drink it comes 1200  for the maximum value 
# 0 0 40 for the solution and (0.0 7.5 0.0 -17.0 -7.0 0.0)  for the duals 

#Depend on what I understand :

# on the duals the second  element is the highest element and represent the hats ..
#so the element that I affect the profit is the hat and  I would like to Increase the amount of the hat from 160 to 800

#After changing the hats amount, I have now a 1440 for the maximum values,  0  0 48 for the solutions and  3   0   0  -2 -22   0  for the duals 






