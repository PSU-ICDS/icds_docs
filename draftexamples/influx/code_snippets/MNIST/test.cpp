#include <iostream>
#include <vector>
#include <fstream>
using namespace std;

int main () {
    
    const int num = 5;
    int array[num] = {4,10,3,9,12};

    ofstream outfile;
 
    for ( int i = 0; i < num; i++ ) {
      outfile.open("tempdir/examplefile.txt", std::ios_base::app);

    
      for ( int j = 0; j < num; j++ ) {
	outfile << array[j] << " ";
      }
      outfile << endl;
            
      outfile.close();

    }
    
    
/*
  vector< vector<int> > vec1;

  vec1.resize( 2,vector<int> (3) );

  int count = 1;

  // fill vec1
  for ( int i = 0; i<2; i++) {
    for (int j = 0; j<3; j++) {
      vec1[i][j] = count;
      count += 1;
    }
  }

  // print vec1
  for ( int i = 0; i<2; i++) {
    for (int j = 0; j<3; j++) {
      cout << vec1[i][j] << " ";
    }
    cout << endl;
  }
  

  //convert to dynamic array
  int** a = new int* [ vec1.size() ];
  for ( int i = 0; i < vec1.size(); i++ ) {
    a[i] = new int [ vec1[1].size() ];
  }
  
  
  // print a
  for ( int i = 0; i<2; i++) {
    for (int j = 0; j<3; j++) {
      a[i][j] = vec1[i][j];
      cout << a[i][j] << " ";
    }
    cout << endl;
  }
  
  
  for ( int i = 0; i < vec1.size(); i++ ) {
    delete [] a[i];
  }
  delete [] a;
*/
}
