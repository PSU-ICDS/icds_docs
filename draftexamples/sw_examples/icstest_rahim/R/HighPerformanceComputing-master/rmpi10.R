library('Rmpi')
d=mpi.spawn.Rslaves(nslaves=10)
b=Sys.time()
c=mpi.iparReplicate(400, mean(rnorm(1000000)))
Sys.time()-b
