# in consosle:
#1.Blackjack <- deck.
#2.facecard<-c("king","queen","jack")
#3.Blackjack$value[Blackjack$face %in% facecard]
#4.Blackjack[Blackjack$face %in% facecard,]
#5.Blackjack$value[Blackjack$face %in% facecard]<-10
#6.Blackjack$value[Blackjack$face == "ace"]<-NA
#7.Hearts <- deck., Hearts$value <- 0 , Hearts$value[Hearts$suit == "hearts"]<-1
#Hearts$value[Hearts$suit == "spades" & Hearts$face == 'queen']<-13
#deck<-deck. << second Deck , deck$order<-1:52

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
#player1H<-1:13 , player2H<-1:13


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
#in console: player1J<-1:2 , player2J<-1:2
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
#PlayBlackJack<-Blackjack

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

#analyzed Dataframe
# I made it manually in the console:
#analyezedhands<-hands[c(2,5),] , it might be wrong but I tried and it failed.

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

# I dont know if my solution is correct or not but I hope so 
#sorry for being late !!
  

