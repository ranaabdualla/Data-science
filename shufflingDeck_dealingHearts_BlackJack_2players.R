shuffle3<- function(deck3){
  shff<- sample(1:52, size = 52)
  deck3<- deck3[shuff,]
  View(deck3)
  }
shuffle4<- function(cdeck3){
 shff<- sample(1:52, size = 52)
  deck3<- deck3[shuff,]
  assign("deck", deck3[-1,],envir = globalenv())
}

deal_hearts<- function() {
  playhearts<-shuffle4(Hearts)
  first_player<- head(playhearts, 13)
  second_player<- tail(playhearts, 13)
  print("Hearts player1")
  print(first_player)
  print("Hearts player2")
  print(second_player)
}

deal_jacks<- function() {
  playjacks<- shuffle4(Blackjack)
  player1<- head(playjacks, 2)
  player2<- tail(playjacks, 2)
  dealer<- playjacks[c(10:11),1:3]
  print("player1")
  print(player1)
  print("Blackjack player2")
  print(j_player2)
  print("Blackjack dealer")
  print(dealer)
}

deal<-function(balckjack){
 dealer1<- playjacks[c(10:11),1:3]

}


hands<-deal(playblackjack){
  hands$player ="P1"
  for(i in 1:5){
    newcard<- deal(playblackjack)
    if (in %in% c(1,4)){
     
       newcard$player<- "p2"
    } else if(i %in% c(2,5)){
        newcard$player<-"dealer"
    }else{
      newcard$player<-"p1"
      }
  }
  hands<-rbind(hands,newcard)
}

  


                  