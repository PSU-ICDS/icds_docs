AA/*
         This is a C++ code that does Gaussian elimination,
         but it is the type of thing that you get when you
         simply convert a Fortran or c code to Java.
         There are NO objects here !!   This is an ugly code....
         Compare to Gauss2.C and Gauss3.C and Gauss.java

         This code solves a system of linear equations using
         Gaussian elimination.   The matrix used is simple
         so that we also have an exact solution to compare to.
         The Matrix looks like:

            |  1  0  0  0  0  ...           0 0  0 |
            |  1 -2  1  0  0         ...    0 0  0 |
            |  0  1 -2  1  0  0      ...    0 0  0 |
            |  0  0  1 -2  1  0 0      ...  0 0  0 |
                 .
                 .
                 .
            |  0  0  0  0         ...  1 -2  1  0  |
            |  0  0  0  0         ...     1 -2  1  |
            |  0  0  0  0         ...     0  0  1  |

And the right hand side vector (B) is:

          B = { 3  0 0 0   ...  0  0 0  5}

So the solution vector is :

          X = { 3 ...  5.0 }

This is a simple little example that is essentially
solving :

          2
         d f
         ----  = 0
            2
         dx
with
     f(0) = 3 and f(L) = 5       

This is purely used to illustrate some c++ and Java
coding approaches.  It is not very interesting from
a numerical analysis viewpoint...

Also, since this uses fixed size arrays, you might
get a segmentation fault if you make the array too big.
 
         author  Prof. Lyle N. Long, lnl@psu.edu
         copyright 2000-2009
*/

#include <iostream>
#include <ctime>
#include <cmath>
using namespace std;

const int nrows = 100;


int main() {

        double myTime=0.0, mflops;

        time_t  tstart, tend;

        cout << endl;
	cout << " This is a Gaussian Elimination Program !" << endl;
	cout << " This uses NO dynamic memory and NO objects " << endl;


        double ratio, ainv;
        double A[nrows][nrows];   // NOT using dynamic memory
        double B[nrows];
        double X[nrows];
        double Xex[nrows];


        for ( int i = 0; i < nrows; i++) {
	    Xex[i] = 2.0 * i/(nrows-1.0) + 3.0;
        }

        for ( int i = 0; i < nrows; i++) {
            for ( int j = 0 ; j < nrows; j++) {
	      A[i][j] = 0.00001 * (i*j);       // just to add some noise...
	    }
	}

        for ( int i = 1; i < nrows-1 ; i++) {
            A[i][i-1] =  1.0;
	    A[i][ i ] = -2.0;
            A[i][i+1] =  1.0;
            B[i]      =  0.0;
	}

        A[0][0] = 1.0;
        A[nrows-1][nrows-1] = 1.0;

        B[0] = 3.0;
        B[nrows-1] = 5.0;


	tstart = time(NULL);
        clock_t begin = clock();


        // forward elimination portion of Gaussian Elimination:

	for ( int i = 1; i<nrows; i++) {

        ainv = 1.0 / A[i-1][i-1];

	    for ( int row = i; row<nrows; row++) {

 	       ratio = A[row][i-1] * ainv;
	       B[row] = B[row] - ratio * B[i-1];

               for ( int j = 0; j<nrows; j++) {
		   A[row][j] = A[row][j] - ratio * A[i-1][j];
	       }
	    }
	}


        // back substitution portion of Gaussian Elimination:

	X[nrows-1] = B[nrows-1] / A[nrows-1][nrows-1];

        for ( int i = nrows-2; i >= 0 ; i--) {

	    //int i = nrows - 2 - ii;

            ainv = 1.0 / A[i][i];

            X[i] = B[i] * ainv;

            for ( int j=i+1; j < nrows; j++) {
		X[i] = X[i] - A[i][j] * X[j] * ainv;
	    }
	}

	tend = time(NULL);
        clock_t end = clock();

        myTime = difftime( tend, tstart );
        double myTime2 = double(end-begin)/CLOCKS_PER_SEC;

	for ( int i=0; i<nrows; i++)
	  cout << " X ( " << i << ")= " << X[i] << endl;

    double error = 0.0;

    for ( int i=0; i<nrows; i++) { 
         	error = error + ( X[i] - Xex[i] ) * ( X[i] - Xex[i] )  ;
	   }

    error = sqrt( error / nrows );

    cout << " Error = " << error  << endl;

    //    cout << " Time = " << myTime << " seconds" << endl;

        cout << "Time using clock=" << myTime2 << endl;

	double nnrows = (double)nrows;

	double ops =  (nnrows*nnrows*nnrows) / 3.0;
	 cout << " number of ops = " << ops << "  (approx.)" <<endl;

       mflops = ops / myTime2 / 1000000.0;
        cout << " Mflops = " << mflops << endl;

        cout << " Memory used = " << 8.0*(1.0*nrows*nrows + 4.0*nrows)/1.0e6 << " Megabytes" << endl;


}

