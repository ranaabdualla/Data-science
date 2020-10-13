#1.Memoryless bar,is tired of running out of inventory and missing a lot of potential sales.
#2.what they need to do to have a probability of 60% or higher of having 2 kegs on hand in the long run?
library(expm)
T <- matrix(c(0.95,0.05,0,0,0.75,0.2,0.05,0,0.2,0.55,0.2,0.05,0.2, 0.55,0.2,0.05), 
            nrow = 4, byrow = TRUE)
colnames(T) = c(0,1,2,3)
rownames(T) = c(0,1,2,3)

T

T%^%2

T%^%5

T%^%20

#what they need to do to have a probability of 60% 
T%^%60

#I think they should Increase there probabilities ... 
