
#include<iostream>
#include<time.h>
#include<cstdlib>
#include<ctime>
#include<stdio.h>
using namespace std;

// - - - - Function Prototypes - - - -
void genrandmat( float**, int, int, float, float );
void matmult( float**, int, int, float**, int, int, float** );
void printmat( float**, int, int );
float randfloat( float, float );


// - - - - Main - - - -
int main( int argc, char** argv ) {

  /* This code takes three input arguments.
     arg1: rows of matrix 1
     arg2: cols of matrix 1 and rows of matrix 2
     arg3: cols of matrix 2
  */

  // check number of input arguments
  if ( argc != 4 ) {  // 4 because .exe call counts as arg #1
    cout << endl << "Error: Did not use 3 input arguments to specify matrix dimensions. Instead used " << argc-1 << "." << endl;
    return 1;
  }

  float opspersec = 0;
  int numops = 0;
  float elapsed_secs = 0;

  // set matrix sizes
  int row1 = atoi( argv[1] );
  int col1 = atoi( argv[2] );  // col1 must equal row2
  int row2 = atoi( argv[2] );
  int col2 = atoi( argv[3] );

  // set matrix value limits
  float lo1 = 0;
  float hi1 = 1;
  float lo2 = 0;
  float hi2 = 1;

  // allocate all matrices
  float** A = new float* [row1];
  for ( int i = 0; i < row1; i++ ) {
    A[i] = new float [col1];
  }
  
  float** B = new float* [row2];
  for ( int j = 0; j < row2; j++ ) {
    B[j] = new float [col2];
  }
  
  float** R = new float* [row1];
  for ( int k = 0; k < row1; k++ ) {
    R[k] = new float [col2];
  }

  // initialize result matrix to zero
  for( int ii = 0; ii < row1; ii++ ) {
    for( int jj = 0; jj < col2; jj++ ) {
      R[ii][jj] = 0.0;
    }
  }
  
  // generate random matrices to be multiplied
  genrandmat( A, row1, col1, lo1, hi1 );
  genrandmat( B, row2, col2, lo2, hi2 );
  
  
  // multiply matrices with error handling
  try {

    // start stopwatch
    clock_t begin = clock();

    // multiply
    matmult( A, row1, col1, B, row2, col2, R );
    
    // end stopwatch
    clock_t end = clock();

    // calculate how much time and number of operations
    elapsed_secs = double( end - begin ) / CLOCKS_PER_SEC;
    numops = row1 * col2 * ( col1 - 1 );

    // calculate ops per sec
    opspersec = double( numops ) / elapsed_secs;

  }
  catch (const char* error) {
    cout << error << endl;
  }

  cout << endl << "Number of operations:  " << numops;
  cout << endl << "Time taken (s):  " << elapsed_secs;
  cout << endl << "Operations per second:  " << opspersec;
  cout << endl << "Program complete." << endl << endl;

  // if small enough, print result matrix
  if ( row1 <= 12 && col2 <= 12 ) {
    cout << "Result matrix =" << endl;
    printmat( R, row1, col2 );
  }


  // clean up memory
  for ( int i = 0; i < row1; i++ ) {
    delete [] A[i];
  }
  delete [] A;
  
  for ( int j = 0; j < row2; j++ ) {
    delete [] B[j];
  }
  delete [] B;

  for ( int k = 0; k < row1; k++ ) {
    delete [] R[k];
  }
  delete [] R;


  return 0;

}  // end MAIN




// - - - - Functions - - - -

void genrandmat( float** A, int m, int n, float lo, float hi ) {
  /* This function generates an 'm'x'n' matrix 'A' of random values between 'lo' and 'hi'.
   Inputs: m  = num rows
           n  = num columns
           lo = lower bound on random numbers
           hi = upper bound on random numbers
   Output (by ref): A = resultant random matrix
  */

  srand(time(NULL));  // initialize random seed

  // generate random matrix
  for ( int i = 0; i < m; i++ ) {
    for ( int j = 0; j < n; j++ ) {

      A[i][j] = randfloat( lo, hi );

    }
  }

}  // end genrandmat()




void matmult( float** M1, int m1, int n1, float** M2, int m2, int n2, float** R ) {
  /* This function takes in two matrices with their respective sizes and multiplies them.
   Inputs: M1 = first matrix to be multiplied
           m1 = rows of first matrix
           n1 = columns of first matrix
           M2 = second matrix to be multiplied
           m2 = rows of second matrix
           n2 = columns of second matrix
   Output: R  = resultant matrix
  */
  
  // check to make sure inner dimensions match
  if ( n1 != m2 ) {
    throw "Inner Dimensions Do Not Match!";
  }

  // multiply matrices
  for ( int i = 0; i < m1; i++ ) {
    for ( int j = 0; j < n2; j++ ) {
      for ( int k = 0; k < n1; k++) {
	R[i][j] += M1[i][k] * M2[k][j];
      }
    }
  }

}  // end matmult




void printmat( float** A, int m, int n ) {
  /* Prints a matrix
     Inputs: A = matrix to print
             m = rows of A
	     n = cols of A
     Outputs: prints A to stdout
   */

  for ( int i=0; i < m; i++ ) {
    for ( int j=0; j < n; j++ ) {    
      printf( "%.2f ", A[i][j] );
    }
    cout << endl;
  }
  cout << endl;

}  // end printmat




float randfloat( float low, float high ) {
  /* Generates a random floating point number
     Inputs: low  = smallest producable random number
             high = largest producable random number
     Outputs: returns a random float
   */  

  float random = ( (float) rand() ) / (float) RAND_MAX;
  float r = random * ( high - low );
  return low + r;
  
}  // end randfloat


