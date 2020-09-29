total<-500.0  #for the player
amount<-1000  # Amount wagered
spin<-0       #spin time
number<-0  
resultVec<- vector("list",36) #save the number of playing this game 
simlength<-36#simulation for 36 Time

#Roulette game
RouletteGame<-function(total,amount,spin,number,resultVec){
  
  print("------WELCOME to ROULETTE GAME------")
  print("Yoaau start off bet with $1000, and your goal is to cash out with as much money as possible.")
  print("If your money goes to $0 or below, you will lose.")
  print("          GOOD LUCK !!!             ") 
  print("your bet amount is:$$")
  print(amount)
  
  for(i in 1:length(simlength)){
   
     choice<-sample(-1:3, size = 1 , replace = TRUE)
    while (choice< 0 ||choice >2){
      print(" put you bet on: ")
      print(choice)
    }
    
    if(choice==2){
      while(number < 1 || number > 36){
        print("put you bet on 1 to 36 :")
        number<-sample(1:36, size = 1, replace = TRUE)
      }
    }
     
    rouletteNum<- sample(1:37 , size = 1, replace = TRUE) #number of the roulette
    spin <-spin+1
    print("the roulette Number is:")
    print(rouletteNum)
    
    if(choice==2){
      if (rouletteNum==number)
        result<-35
      else
        result<-0
    }
    else {
      if(rouletteNum==0 || rouletteNum%%2 != choice)
        result<-0
      else
        reslut<-1
      
    }
    # shows the result wins or lose , amount and total
    #in case the player wins !
    if(result > 0 ){
      print("    Congratulatons !!!   ")
      print("   You win this game !!  ")
      
      print("You now got ")
      Result<- result*amount
      print(Result)
      
      print("Here's your money back:")
      money<- (result + 1) * amount    #money for the winner
      print(money)
      
      total <- (result + 1) * amount + total
       win<-0
       win <-win+1       #Winning counter
      resultVec[i]<- -(rouletteNum +1) # the( - ) represent the casino lose 
      
    } else{
      #in case player lose
      
      print("YOU LOSE ): , SORRY AND GOODLUK FOR THE NEXT TIME !")
      
      print("You got lost ")
      Result<-(result + 1) * amount
      print(Result)
      
      total<-total - (result + 1) * (amount) 
      lose<-0
      lose<-lose+1
      resultVec[i]<-rouletteNum + 1

    }
  }
  result
  total
  lose 
  win
  
}


#slot machine

SlotMachine<-function(){
  
#symbols of the slot machine
symbols <- c("@","#","*")
  count <- 0
  slotProfit <-0
for(in in 1:length(simlength)){  
  while(TRUE){
    coins <- 100
    print("WELCOME TO THE GAME")
    #when the player has coins to play with
    while (coins > 0){
      
      cat(" Your totla coins:", coins)
      bet <- readline(prompt="Enter your bet amount: ")
      bet <- as.integer(bet)
      
      if (bet > coins) {
        print("SORRY! Not enough coins")
      } else {
        coins <- coins - bet
        first = sample(symbols,1)
        second = sample(symbols,1)
        third = sample(symbols,1)
        
        cat("\n")
        
        
        cat("|", sample(symbols,1), "|", sample(symbols,1) , "|", sample(symbols,1), "|")
        cat("\n")
        
        #the real line to test
        cat("|", first , "|", second , "|", third, "|")
        cat("\n")
        
        cat("|", sample(symbols,1), "|", sample(symbols,1) , "|", sample(symbols,1), "|")
        cat("\n")
        
        #to check if the three symbols are the same
        if (first == second & second == third){
          double <- 2 * bet
          cat("You won", double, "coins,")
          coins <- coins + double
          slotProfit <- slotProfit - bet
        } else {
          losses <- cat("You lost.")
          losses 
          slotProfit <- slotProfit + bet
          count <- count + 1
          
          
          
        }
        
        q <- readline(prompt="Do you want to keep playing? Y/N ")
        if (q == "N"){
          break
        } else if(q == "Y") {
          next
        }


      }
    }
    cat("You have 0 coins")
    
    cat("\n")
    
    cat("casino profit of this game is", profit)
    break
  }
  
  slotProfit }
}


#profit
profit<- function(){
result
lose
win
amount 
slotProfit
if(result > 0 ){
  print("the casino has been lose  in the ROULETTE GAME")
  loseamountRoulette<-(result+amount)*lose
  print(loseamountRoulette)
  
  print("number of lose")
  print(win)
  
  print("the average number of loses")
  AVGlosesRoulette<-win/100
  print(AVGlosesRoulette)

  }else{
    print("the has gain in the ROULETTE GAME")
    winamount<-(total+(result+amount))*win
    print(winamount)
    
    print("number of winnings")
    print(lose)
  
  print("the average number of loses %:")
  AVGwinning<-lose/100
  print(AVGwinning)
  }

# since the starter amount for the player = 100 , we will compare
# if the final amount greater than or less than 100 which is the start amount
  if(slotProfit > 100){ #its meant that The player win and the casino lose
    print("the casino has been lose  in the slot machine")
    amountloseSM<- (slotProfit - 100) 
    print(amountloseSM)
    
  } if(slotProfit< 100){
    print("the has gain  in the slot machine")
    gain<-slotProfit + 100
    print(gain)
  }
 print("total amount of lose for the CASINO ")
 loser<- loseamountRoulette +amountloseSM
 print(loser)
 print("total gain for the CASINO")
 winnings<-winamount+gain
}


