#include<stdio.h>
#include<math.h>
#include <iostream>
#include <time.h>

using namespace std;



int main(){

clock_t t;
  int f;
  t = clock();



int n=1000000;
float *A,*result;


A=new float [n];
result=new float [n];

for (int i=0; i<n; i++)
        A[i]=i+1;



for (int i=0; i<n; i++)
        result[i] = A[i]+2;



for (int i=0; i<n; i++)
        std::cout << result[i] << " " << endl ;

t = clock() - t;
  printf ("It took me %d clicks (%f seconds).\n",t,((float)t)/CLOCKS_PER_SEC);


}

