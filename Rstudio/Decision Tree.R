install.packages('rpart')
library(ggplot2)
library(rpart)

fit <- rpart(Sepal.Width ~ Sepal.Length + 
               Petal.Length + Petal.Width + Species,  
             method = "anova", data = iris) 
fit <- rpart(Sepal.Width ~ Sepal.Length + 
               Petal.Length + Petal.Width + Species,  
             method = "anova", data = iris) 




Decision_tree<-function(fit){
  
  png(file = "decTreeGFG.png", width = 600,  
    height = 600)

plot(fit, uniform = TRUE, 
     main = "Sepal Width Decision  
                 Tree using Regression") 
text(fit, use.n = TRUE, cex = .7) 

dev.off() 
print(fit)

df  <- data.frame (Species = 'versicolor',  
                   Sepal.Length = 5.1, 
                   Petal.Length = 4.5, 
                   Petal.Width = 1.4) 
cat("Predicted value:\n") 
predict(fit, df, method = "anova") }
