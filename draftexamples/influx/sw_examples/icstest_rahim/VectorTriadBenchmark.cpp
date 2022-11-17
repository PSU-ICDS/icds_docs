//Vector Triad Benchmark
//Compile line: g++ VectorTriadBenchmark.cpp -O3 -mavx2 -march=native -ffast-math

#include <iostream>
#include <fstream>
#include <math.h>
#include <sys/time.h>

//get_walltime() from question
void get_walltime(double* wcTime)
{
     struct timeval tp;
     gettimeofday(&tp, NULL);
     *wcTime = (double)(tp.tv_sec + tp.tv_usec/1000000.0);
}

int dummy(double* A, double* B, double* C, double* D)
//dummy function to combat if the compiler tries something funky!
{
return 0 ;
}

//main function
int main( )
{
int N=2,R=10000;
//p=power

for(int p=1;p<29;p++)
{

double S,E,MFLOPS;
  N=pow(2,p);
  R=10000/(10*p);
  double *A=new double[N];
  double *B=new double[N];
  double *C=new double[N];
  double *D=new double[N];

  for(int i=1;i<=N;i++)
  {
    A[i]=0;
    B[i]=1;
    C[i]=2;
    D[i]=3;
  }

get_walltime(&S);

for(int j=0;j<R;j++)
{
for(int i=0;i<N;i++)
{
A[i]=B[i]+C[i]*D[i];
}
if(A[2]<0)
{
  dummy(A,B,C,D);
}
}

get_walltime(&E);

//MFLOPS = R*N*2.d0/((E-S)*1.d6) :: calculate MFLOPS
MFLOPS=R*N*2/((E-S)*1e6);
std::cout<<"N="<<N<<";"<<"R="<<R<<";"<<"E="<<E<<";"<<"S="<<S<<";"<<"Walltime="<<(E-S)<<";"<<"MFLOPS="<<MFLOPS<<";\n";
delete [ ] A;
delete [ ] B;
delete [ ] C;
delete [ ] D;
}
return 0;
}
