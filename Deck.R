#Write custom functions for shuffling the deck:
shuffle <- function(deck2) { 
  shuff<- sample(1:52, size = 52)
  deck2[shuff,]
 

  #Write a custom function for dealing cards to 2 players in hearts:
  
dealling<- function(heart){
    for(row in 1:heart){
      player1<- heart[row,"face","suit","value"]
      player1<- heart[row,"face","suit","value"]
      
    } 
 
   
