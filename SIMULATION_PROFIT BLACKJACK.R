# in consosle:
deck. <- read.csv("C:/Users/RA/Downloads/deck (1).csv")
Blackjack <- deck.
facecard<-c("king","queen","jack")
Blackjack$value[Blackjack$face %in% facecard]
Blackjack[Blackjack$face %in% facecard,]
Blackjack$value[Blackjack$face %in% facecard]<-10
Blackjack$value[Blackjack$face == "ace"]<-NA
Hearts <- deck.
Hearts$value <- 0 
Hearts$value[Hearts$suit == "hearts"]<-1
Hearts$value[Hearts$suit == "spades" & Hearts$face == 'queen']<-13
deck<-deck. 
deck$order<-1:52

#shuffling the Deck
shuffle<- function(deck1){
  shuff<- sample(1:52, size = 52)
  deck1<- deck1[shuff,]
  View(deck)
}

#assign it to the global
Gloableshuffle<- function(deck1){
  Gshuff<- sample(1:52, size = 52)
  deck1<- deck1[Gshuff,]
  assign("deck", deck[-1,],envir = globalenv())
}

#dealling Card Hearts
#assing the players in console:
player1H<-1:13 
player2H<-1:13


dealinghearts<- function() {
  playhearts<- Gloableshuffle(Hearts)
  player1H<- head(playhearts, 13)
  player2H<- tail(playhearts, 13)
  print("Hearts first palyer")
  print(player1H)
  print("Hearts second player")
  print(player2H)
}

#dealing the blackjack
#in console: 
player1J<-1:2 
player2J<-1:2
deallingjacks<- function() {
  playjacks<- Gloableshuffle(Blackjack)
  player1J<- head(playjacks, 2)
  player2J<- tail(playjacks, 2)
  dealer<- playjacks[c(10:11),1:3]
  print("Blackjack first player")
  print(player1J)
  print("Blackjack second player")
  print(player2J)
  print("Blackjack dealer")
  print(dealer)
}

#dealing Function

deal<-function(currentdeck){
  card<-currentdeck[1,]
  assign("playblackjack", currentdeck[-1,],envir = globalenv())
  card
}

#in consloe: Assigning blackjack tp playblackjack

PlayBlackJack<-Blackjack

#Creating Hands dataFrame

hands<-deal(PlayBlackJack)
hands$player = "p1"
for (i in 1:5){
  newcard <- deal(playblackjack)
  if (i %in% c(1,4)){
    newcard$player<- "p2"
  }else if (i %in% c(2,5)){
    newcard$player<- "dealer"
  }else{
    newcard$player<- "p1"
  }
  hands<-rbind(hands,newcard)
}
View(hands)

#analyzed Data frame
# I made it manually in the console:
analyezedhands<-hands[c(2,5),] 
#it might be wrong but I tried and it failed.

score_hand<- function(analyezedhands){
  if (sum(analyezedhands$face == "ace")>0){
    if(sum(analyezedhands$value,na.rm = TRUE)>10){
      score<-sum(analyezedhands$value,na.rm = TRUE) + 1
    }else{
      score<-sum(analyezedhands$value,na.rm = TRUE) + 11
    }
  }else{
    score<-sum(analyezedhands$value,na.rm = TRUE)
  }
  score
}



#first player strategy: if the player has cards LESS THAN 12 
# he must ask for an extra card "dealing"


score<- score_hand(hands[hands$player == "p1",])
while(score<12){
  newcard<-deal(playblackjack)
  newcard$player<- "p1"  
  hands<-rbind(hands,newcard)
  score<-score_hand(hands[hands$player == "p1",])

}

#first player strategy: if the player has cards more than 17 so he stop
#taking any cards "stop dealling"

score <- score_hand(hands[hands$player == "p2",])
while(score<17){
  newcard<-deal(playblackjack)
  newcard$player<- "p2"
  hands<-rbind(hands,newcard)
  score<-score_hand(hands[hands$player == "p2",])}



##########################################
#                                        #
#  SIMULATION AND PROFIT OF BLACKJACK    #
#                                        #
##########################################
winnings<-vector("integer",10000)
Acc_winnings<-vector("integer",10000)

#rules#
#1.player bet 1$ and if the player win he get his money +1
#2.if player loss he loss 1$
#3.if a tie happens , player recovers his money
#chance of player wins0.4222 ,chance of tie is 0.0848
#chance of dealer win is 0,493

playernum<-6

for (i in 1:length(winnings)){
onehand<- sample(c("D","T","P"),playernum,prob = c(0.4222,0.0848,0.493),replace=TRUE)
win[i]<-length(onehand[onehand=="P"])*-1+length(onehand[onehand=="D"])
if(i !=1 ){
  Acc_winnings[i]<-Acc_winnings[i-1] + win[i]
}else{
  Acc_winnings[i]<-win[i]
}
}

plot(acc_blackjackhands)
plot(win)
hist(acc_blackjackhands)
hist(win)



BJhands<-vector("integer",10000)
Acc_BJhands<-vector("integer",10000)

number_player<-2

#Probability of Jack winning = 49/100 >>>0.49
#probability of the casino winning = 51/100 >>0.51


#simulation

for (i in 1:length(BJhands)){
  hand<-sample(c("jack","casino"),number_player,prob=c(0.49,0.51),replace = TRUE)
 
   winBJ[i]<-length(hand[hand=="jack"])*-1+length(hand[hand=="casino"])
   if(i == score ){ # if the dealer and player Has the same total card the player wins
     Acc_BJhands[i]<-Acc_BJhands[i-1] + winBJ[i]
   }else{
     Acc_BJhands[i]<-winBJ[i]
   }
}
plot(acc_blackjackhands)
plot(win)
hist(acc_blackjackhands)
hist(win)


totalFunds<-10000 #total money in hand the player is starting with
WagerAmount<-100 #the betting amount each time the player plays
totalplays<- NULL #the number of times the player bets on this game
playnum<- vector("list",length = 10000) #Empty list
str(playnum)
funds<- vector("list",10000)
str(funds)

profit<-function(totalFunds,WagerAmount,totalplays){
  
  profit<-1 ##Start with profit number 1
 
   while (play < totalplays) {
    if(score < 20){
      totalFunds<- totalFunds+wargeamount
      playnum[play]
      funds[totalfunds]
      
    } else{ 
      totalFunds<-totalFunds-wargeamount
      playnum[play]
      funds[totalFunds]
      
      profit<-profit + 1
    }
  }
 
}

plot(profit)
hist(profit)



