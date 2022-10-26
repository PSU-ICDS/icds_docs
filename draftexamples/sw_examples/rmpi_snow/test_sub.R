
#### Mac/Linux ONLY ####
library(Rmpi)

library(doParallel)
library(snow)
#library(foreach)
#makeCluster(mpi.universe.size(),type="mpi")
detectCores()
#mpi.universe.size()
m = mpi.universe.size()

#workers=makeCluster(mpi.universe.size(),type="MPI")
workers=makeCluster(m,type="MPI")
registerDoParallel(workers)

myfun<-function(ib){
write(paste(ib,Sys.time()),"ib_log_file.txt",append=TRUE)
Sys.sleep(10)
}

write(paste('number of cores:',m),"ib_log_file.txt",append=FALSE)
Out<-foreach(ib = 1:m,.combine="rbind",.errorhandling='stop') %dopar% myfun(ib)
stopCluster(workers)
mpi.quit()


########################


