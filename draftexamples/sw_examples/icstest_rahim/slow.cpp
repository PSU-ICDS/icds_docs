// compiles with:
// g++ slow_code.cpp -o slow_code


#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <math.h>


void get_walltime(double* wcTime) {

     struct timeval tp;

     gettimeofday(&tp, NULL);

     *wcTime = (double)(tp.tv_sec + tp.tv_usec/1000000.0);

}

// complex algorithm for evaluation
void myfunc(std::vector<std::vector<double> > &v_s, 
	std::vector<std::vector<double> > &v_mat, std::vector<int> &i_v)
{
	// this assumes that the two dimensional vector is square 

	double d_val;

	for (int j = 0; j < v_s.size(); j ++)
	{
		for (int i = 0; i < v_s[0].size(); i++)
		{
			d_val = round(fmod(i_v[i],256)); // this should return an integer
			v_mat[i][j] = v_s[i][j]*(sin(d_val)*sin(d_val)-cos(d_val)*cos(d_val));
		}
	}
}

int main(int argc, char *argv[])
{

	// this should be called as> ./slow_code <i_R> <i_N>

	int i_R = 1000;	
	int i_N = 100;

	double d_S, d_E;

	// parse input parameters 
	if (argc >= 2)
	{
		i_R = atoi(argv[1]);
	}

	if (argc >= 3)
	{
		i_N = atoi(argv[2]);
	}

	// some declarations
	std::vector<std::vector<double> > vd_s(i_N, std::vector<double>(i_N) );
	std::vector<std::vector<double> > vd_mat(i_N, std::vector<double>(i_N) );
	std::vector<int> vi_v(i_N);

	// populate memory with some random data
	for (int i = 0; i < i_N; i++)
	{
		vi_v[i] = i * i;
		for (int j = 0; j < i_N; j++)
			vd_s[i][j] = j + i;
	}

	// start benchmark
	get_walltime(&d_S);

	// iterative test loop
	for (int i = 0; i < i_R; i++)
	{
		myfunc(vd_s, vd_mat, vi_v);
	}

	// end benchmark
	get_walltime(&d_E);

	// report results
	printf("Elapsed time: %f\n", d_E - d_S);

	return 0;
}
