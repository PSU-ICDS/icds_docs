
#include <iostream>
#include <stdlib.h>
#include <cstdlib>
#include <chrono>
#include <fstream>
using namespace std;
using namespace std::chrono;


// function prototypes
void genNumArray( int*, int );
int randInt( int, int );
void printArray( int*, int, string );
bool checkIfSorted( int*, int, string );
void deleteElement( int*, int&, int );
void stalinmerge( int*, int );
void merge( int*, int&, int*, int );




// - - - - MAIN - - - -
int main ( int argc, char* argv[] ) {

  // initialize random seed
  srand( time(NULL) );

  // check command line input
  if ( argc != 3 ) {

    cout << "Invalid number of command line arguments!" << endl;
    return 1;

  }

  // set up some vars
  int lA = 0;
  int maxsize = atoi( argv[1] );
  int stepsize = atoi( argv[2] );
  int iter = maxsize / stepsize;

  // file setup
  ofstream outfile;
  outfile.open( "smdata_" + to_string( maxsize ) + "_" + to_string( stepsize ) + ".txt" );

  // size-iterating for loop
  for ( int i = 1; i <= iter; i++ ) {

    // allocate array
    int* A;
    lA = stepsize * i;
    A = new int [lA];
    
    genNumArray( A, lA );
    
    //printArray( A, lA, "A (original)" );
    
    // start timing
    auto start = high_resolution_clock::now();

    stalinmerge( A, lA );
    
    // end timing
    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<microseconds>(stop - start);

    //printArray( A, lA, "A (new)" );

    cout << "Time taken by stalin-merge routine for " << lA << " elements:  " 
	 << duration.count() << " microseconds" << endl; 

    // write data to file
    outfile << lA << " " << duration.count() << endl;

    // mr. clean
    delete[] A;
    
  }

  outfile.close();

  return 0;

}
// - - - - END MAIN - - - -



// generates a list of random integers
void genNumArray( int* L, int length ) {

  int min = 0;
  int max = 100;

  for ( int i = 0; i < length; i++ ) {
    L[i] = randInt( min, max );
  }

}  // end genNumArray ()




// generates a random integer
int randInt( int min, int max ) {

  int n = min + ( rand() % static_cast<int>(max - min + 1) );
  return n;

}  // end randInt()




// print array
void printArray( int* L, int length, string title ) {

  if ( length <= 100 ) {
    
    cout << title << ":  ";
    for ( int i = 0; i < length; i++ ) {
      cout << L[i] << " ";
    }
    cout << endl;
    
  } else {

    cout << "Array of length " << length << " is too large to print..." << endl;

  }

}  // end printArray()




// check if list is sorted or not
bool checkIfSorted( int* L, int length, string title = "" ) {

  bool sorted = true;

  for ( int i = 0; i < length - 1; i++ ) {
    if ( L[i] > L[i+1]  ) {
      sorted = false;
    }
  }

  if ( title != "" ) {
    if ( !sorted ) {
      cout << title << " is not sorted properly!" << endl;
    } else if ( sorted ) {
      cout << title << " is sorted!" << endl;
    }
  }

  return sorted;

}  // end checkIfSorted()




// delete element index 'x' from an array and shorten
void deleteElement( int* L, int& l, int x ) {

  for ( int i = x; i < l-1; i++ ) {

    L[i] = L[i+1];

  }

  l = l - 1;


}  // end deleteElement()




// 
void stalinmerge( int* L, int l ) {

  if ( l <= 1 ) {

    //cout << "List is of length 0 or 1, so it is sorted by definition.\n";

  } else {

    bool sorted = checkIfSorted( L, l );

    if ( sorted ) {

      //cout << "List already sorted.\n";

    } else if ( ~sorted ) {

      // create "kick-out" array Lu (unsorted)
      int* Lu = new int[l];
      int lu = 0;

      // stalin sort array L
      for ( int i = 0; i < l; i++ ) {
      
	if ( L[i+1] < L[i] ) {
	
	  Lu[lu] = L[i+1];
	  lu = lu + 1;
	  deleteElement( L, l, i+1 );
	  if ( i < l-1 ) {
	    i = i - 1;
	  }

	}
	
      }  // end for
  
      //printArray( L, l, "Main Array: " );
      //printArray( Lu, lu, "Kick-out Array: ");
    
      // stalin-merge sort Lu
      stalinmerge( Lu, lu );
      
      // merge L and Lu
      merge( L, l, Lu, lu );
      

      //cout << "List has been sorted via stalin-merge sort!\n";
      
    }

  }  

}  // end stalinmerge()




// merge two sorted arrays (L2 into L1)
void merge( int* L1, int& l1, int* L2, int l2 ) {

  int j = 0;
  for ( int i = 0; i < l1; i++ ) {

    if ( j >= l2 ) {

      break;

    } else if ( j < l2 && L2[j] < L1[i] ) {

      // insert L2[j] before L1[i]
      for ( int k = l1; k > i; k-- ) {

	L1[k] = L1[k-1];

      }

      L1[i] = L2[j];
      l1 = l1 + 1;
      j = j + 1;
      
    }

  }

  // append rest of L2 list
  if ( j < l2 ) {

    for ( int jj = j; jj < l2; jj++ ) {

      L1[l1] = L2[jj];
      l1 = l1 + 1;

    }

  }

}  // end merge()

