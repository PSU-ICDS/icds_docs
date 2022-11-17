//Rahim Charania
////rkc10
////g++ bts.cpp -fopenmp -mavx -ffast-math -march=native



#include <omp.h>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <sys/time.h>
#include <iostream>
using namespace std ;




int MAX_NUM_THREADS;

double sum_total;

void getwalltime (double* wcTime )
{
struct timeval tp ;
gettimeofday(&tp , NULL) ;
*wcTime = (double) (tp.tv_sec+tp.tv_usec/1000000.0) ;
}

double fast_sum (double* pd_input , int i_N )
{

omp_set_num_threads(MAX_NUM_THREADS) ;
int i_NumThreads ;

double sum_tot = 0.0 ;
double *sum;
sum = new double [i_N] ;

double *B;
B = new double [ i_N ] ;

for(int i=1;i<=i_N;i++)
{
B[ i ] = pd_input [ i ] ;
}

int step;

for(int j=1;j<=log2( i_N );j++)
{
step = j + 1 ;

int ID = omp_get_thread_num( ) ;
int i_nThreads = omp_get_thread_num() ;
int i ;
if ( ID == 0)
i_NumThreads = i_nThreads ;
for ( int i =ID; i < i_N/pow( 2 , step ) ; i++ )
{
sum[ i ] = B[2*i] + B[ 2 * i - 1 ] ;
}



for ( int i = 0 ; i < i_N/pow( 2,step ) ; i++)
{
B[ i ] = sum[ i ] ;
}
}
sum_tot = B[ 1 ] ;
return sum_tot ;
delete [] sum;
delete [] B;
}

int main (int argc , char **argv )
{

for(int i_k=1;i_k<=28;i_k++)
{
long n = pow( 2 , i_k ) ;
double *A;
A = new double [n] ;
double d_t1 , d_t2 ;
MAX_NUM_THREADS = atoi(argv[1]) ;
printf ( "\nNum Threads used = %i \n" , MAX_NUM_THREADS) ;
double sum_tot;

for ( int i = 0 ; i < n ; i++)
{
A[i] = i + 1.0;
}
getwalltime (&d_t1) ;
#pragma omp parallel
{
sum_total = fast_sum (A, n) ;
printf( "SUM = %.0f \n" , sum_total) ;

}
getwalltime (&d_t2) ;

printf( "Wall time = %f \n" , d_t2 - d_t1 ) ;

delete [] A;
}
}
