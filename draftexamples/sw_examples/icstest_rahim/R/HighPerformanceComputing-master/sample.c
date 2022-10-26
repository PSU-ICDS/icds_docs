a=Sys.time()

A=1:1000000
result=vapply(A,function(x) x+2,FUN.VALUE=0)


Sys.time()-a

