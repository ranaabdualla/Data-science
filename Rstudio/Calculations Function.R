marginals<- 0.20
conditionals<-0.80

calculations<-function(marginals,conditionals){
#P(B|A) = P(A and B) / P(A) >> conditional probability
  
 
  A<- marginals #Event
  B<-conditionals   #condition for the Event 
  
  


#calculate conditional probability
  if(B>0.0){
    AinterB<- A*B  # Do the intersection 
     prob_cond<- AinterB /B
     
     cat(" the probability of the conditionals Event happens is", prob_cond)
  }
 
   
#calculate the marginals.
 
  if(B>0.0){
     prob_marg<- A/B
     cat(" the marginals distribution is ", prob_marg)
  }
  
# calculate the joints
  joints<- A*B
  
  cat(" the joints is ", joints)
  
}



