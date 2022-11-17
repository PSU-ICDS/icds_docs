n = 100
a = zeros(n)
@parallel for i = 1:n
    a[i] = i*0.1;
    println("Processor id: ",myid())

end
println("Job done.")
