
# libraries
import numpy as np

# open file for reading
dimf = open( 'dim_file.txt', 'r' );

# read in file of matrix dimensions
rawdims = [];
for line in dimf:
    rawdims.append( line.strip() );

# parse matrix dimensions
Adim1 = int( rawdims[0] );
Adim2 = int( rawdims[1] );
Bdim1 = int( rawdims[1] );
Bdim2 = int( rawdims[2] );
Rdim1 = Adim1;
Rdim2 = Bdim2;

# print matrix dimensions
print( "\nA is of dims " + str(Adim1) + " x " + str(Adim2) );
print( "B is of dims " + str(Bdim1) + " x " + str(Bdim2) + "\n");

# create matrices of correct sizes
A = np.random.rand( Adim1, Adim2 );
B = np.random.rand( Bdim1, Bdim2 );

# multiply
R = np.matmul( A, B );
print( "Matrix multiply complete!\n" );

# if small enough, print result
if Rdim1 < 10 and Rdim2 < 10:
    print(R)
