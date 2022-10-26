#include <iostream>
using namespace std;

void arrayfcn( float**& arr, int m, int n ) {

  /* I want to allocate an array inside a function as if m and n
     are only known inside this function. Is there a way to do this? */
  arr = new float* [ m ];
  for (int i = 0; i < m ; i++) {
    arr[i] = new float[ n ];
  }
  
  int count = 0;
  for (int j = 0; j < m; j++ ) {
    for (int k = 0; k < n; k++ ) {
      arr[j][k] = count;
      count++;
    }
  }

}


int main () {

  int m = 3;
  int n = 4;

  float** array = NULL;

  arrayfcn( array, m, n );

  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++ ) {	
	cout << array[i][j] << " ";
    }
    cout << endl;
  }


}
