
#include <iostream>
#include <cstdlib>
using namespace std;


void vec_add( int*, int*, int*, int );

int main(){

  int* x;
  int* y;
  int* z;
  int n = 10;
  x = new int [n];
  y = new int [n];
  z = new int [n];

  for ( int i = 0; i < n; i++ ){
    
    x[i] = rand() % 101;
    y[i] = rand() % 101;
    
  }

  vec_add( x, y, z, n );

  cout << endl << "x[]\ty[]\tz[]" << endl;
  for ( int ii = 0; ii < n; ii++ ) {

    cout << x[ii] << "\t" << y[ii] << "\t" << z[ii] << endl;

  }

  return 0;

}


void vec_add ( int* v1, int* v2, int* result, int N ) {
  
  for ( int i = 0; i < N; i++ ) {

    result[i] = v1[i] + v2[i];

  }

}
