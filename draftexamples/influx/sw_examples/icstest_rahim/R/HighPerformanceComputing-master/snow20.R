library(snow) 

#populate random big data 

data <- data.frame(a=seq(1,1000000,1),b=seq(10,1000000,10),c=runif(100000))
 
 
a=Sys.time()
serial <- apply(data,1, function(x) (x[1]*x[3]+x[2])*x[3]-9 > 20)
Sys.time()-a
 
### Equivalent parallel execution ###
 
b=Sys.time()
Mycluster <- makeCluster(20)
 
# The equivalent for the first alternative would be very easy
 

parallel <- parRapply(Mycluster,data, function(x) (x[1]*x[3]+x[2])*x[3]-9 > 20)
Sys.time()-b
