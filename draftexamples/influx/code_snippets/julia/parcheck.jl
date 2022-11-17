
using Distributed
@everywhere using Base.Threads


# set size parameters
addprocs( nthreads() )
@everywhere module tmod
       using Base.Threads
       M = nthreads()	# numcols
       N = 10		# numrows
end

@everywhere using ..tmod
@everywhere N = tmod.N
@everywhere M = tmod.M

println( String( "generating a $N x $M initial matrix to be distributed to available processors..." ) )
global pubmat_init = rand( 0:10, N, M )
global pubmat_post = zeros( Int, N, M )

# could use this to check accuracy
# check not implemented
# pubmat_init_copy = pubmat_init

# distribute work
println( "distributing work..." )
@everywhere function localproc( icol, A_init )

	    B_init = rand( 0:10, M )
	    B_post = zeros( Int, N )

	    for n in 1:N
	    	for m in 1:M
	    	    B_post[ n ] = B_post[ n ] + A_init[ n ] * B_init[ m ]
		end
	    end

	    #colresult = [ icol, B_post[:] ]
	    #return colresult
	    	    
	    return B_post
end

for col in 1:M
	    pubmat_post[ :, col ] .= remotecall_fetch( localproc, col+1, col, pubmat_init[ :, col ] )
end

println( "all work done." )


# generate output
rmprocs()
#println( "- - - - - - - - - -" )
#println( "pubmat_init = ", pubmat_init )
#println( "pubmat_post = ", pubmat_post )
#println( "- - - - - - - - - -" )
#println( "finished." )
