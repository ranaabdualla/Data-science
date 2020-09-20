dice1<-sample(dice10 , size = 6, replace = TRUE , prob=prob10)

dice.roll10<- function(dice10,prob10){
  dice_1<-sample(dice10 , size = 6, replace = TRUE , prob=prob10)
  sum(dice_1)}

dice2<-sample(dice20 , size = 6, replace = TRUE , prob=prob20)
dice.roll20<- function(dice20,prob20){
  dice_2<-sample(dice20 , size = 6, replace = TRUE , prob=prob20)
  sum(dice_2)}


check<- function(dice1,dice2){
  for(i in 1:6){
    if (dice1>6){
      print(i+dice1)
    }}
  
  for (j in 1:6){
    if (dice2>16) {
      print(j+dice2)}}
}

