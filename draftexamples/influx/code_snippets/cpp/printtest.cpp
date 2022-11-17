#include<iostream>
using namespace std;

int main(){

  int n = 10;
  int c = 10000;
  int z = 0;

  for ( int i = 0; i < n; i++ ) {
    cout << "Hello #" << i;
    for ( int j = 0; j < c; j++ ) {
      z = i + j;
    }
    cout << "  Sum: " << z << endl;
  }

  return 0;

}
