println("Hello from Julia")
np = nprocs()
println("Number of processes: $np")

for i in workers()
    host, pid = fetch(@spawnat i (gethostname(), getpid()))
    println("Hello from process $(pid) on host $(host)!")
end
