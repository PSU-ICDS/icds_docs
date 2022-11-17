
import sys
import numpy as np
import random
import time


# Generate an array object with size 1 GB
def genGB():

    # some size parameters
    kb = 1024;
    gb = kb**3;

    # generate a ~1 GB array
    x = [];
    while True:  # do while loop
        x.append( np.int8( 0 ) );
        if sys.getsizeof( x ) >= gb:
            break;

    return x;


# - - - - MAIN - - - -

start = time.time()  # start timing
outfile = open( "memoutput.txt", "w+" )

# create array incrementing in size by ~1GB each iteration
X = [];
x = genGB();
maxsizegb = 50;
for i in range ( maxsizegb + 1 ):
    X.extend(x);
    
    # determine size in GB
    Xsizegb = sys.getsizeof(X) / (1024**3);
    print( f'sys.getsizeof(X) = {Xsizegb:.2f}  GB' )
    outfile.write( f'sys.getsizeof(X) = {Xsizegb:.2f}  GB\n' )
    
# runtime info
end = time.time();  # end timing
t = end - start;
print( f'Time Elapsed [s]: {t:.2f}' )
outfile.write( f'Time Elapsed [s]: {t:.2f}\n' )
outfile.close()
print( 'Output file closed.')
sys.exit()
