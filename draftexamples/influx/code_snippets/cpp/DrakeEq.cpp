#include<iostream>
#include<stdlib.h>
using namespace std;

float drakeeqn( float, float, float, float, float, float, float );

int main( int narg, char** argv) {

	int n = narg - 1;
	if (n != 7) {
		cout << "Drake's Equation needs 7 input values!" << endl;
	}

	float* parm = new float[n];

	for (int i=0; i < n; i++ ) {
		parm[i] = atof(argv[i+1]);
	}

	float N = drakeeqn(parm[0], parm[1], parm[2], parm[3], parm[4], parm[5], parm[6]);

	if (N>100) {
		cout << "ALIENS EXIST" << endl;
	} else {
		cout << "We are all alone." << endl;
	}

	delete[] parm;

	return 0;

}

float drakeeqn( float R, float fp, float ne, float fl, float fi, float fc, float L ) {

	float N = R * fp * ne * fl * fi * fc * L;

	return N;
}
