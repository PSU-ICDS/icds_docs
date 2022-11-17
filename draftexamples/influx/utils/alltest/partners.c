#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include "partners.h"


int slide_by(int my_id, int nprocs, int **partners){
	int total;
	int i;
	int p;
	int *nghbors;
	/*
	We need an even number to make this work right, so we'll round up.
	*/
	total = (nprocs % 2) ? nprocs + 1 : nprocs;
	
	/*
	Get the space for the neighbors array.
	*/

	nghbors = (int *)calloc(sizeof(int),total+1);
	partners[0] = nghbors;

	/*
	We want everyone communicating with themself at the same time,
	  so I set up an extra itteration for this...
	*/

	nghbors[0] = my_id;

	/*
	We implement this kind of like a couple of sliding lines.
	For example if we have 6 ranks:

		0 1 2 3 4 5
		5 4 3 2 1 0 5 4 3 2 1 0

	At each itteration, we slide the lines past each other by a 
	  single position.  We end up with each pair of nodes having a
	  new partner each time and being done within 6 turns.

	*/

	for(i=0;i<total;i++){
		p = total - 1 - my_id - i;
		if(p < 0){
			p += total;
		}
		/*
		From the illustration above, you can see that there
		will be one time for each node that they will need
		to communicate with themself.

		Since we're trying to test the network, we want to
		keep all the links busy, instead of having nodes just
		talk to themselves.  So, if I'm communicating with
		myself, there must be someone else with this problem.
		*/
		if(p == my_id){
			p -= total/2;
			if (p < 0){
				p += total;
			}
		}
		nghbors[i+1] = p;
	}
	return(total+1);
}

int full_blown(int my_id, int nprocs, int **partners) {
	int total;
	int i;
	int p,pos;
	int *nghbors;
	/*
	We need an even number to make this work right, so we'll round up.
	*/
	total = (nprocs % 2) ? nprocs + 1 : nprocs;
	
	/*
	Get the space for the neighbors array.
	*/

	nghbors = (int *)calloc(sizeof(int),total+1);
	partners[0] = nghbors;

	/*
	We want everyone communicating with themself at the same time,
	  so I set up an extra itteration for this...
	*/

	nghbors[0] = my_id;

	/*
	Think of a queue of n ints

	  0, 1, 2, ..., n-1

	Rotate these left 1 at a time.

	After the ith rotation, my number is at position: my_id - i mod n

	After the ith rotation, position k has value:  k+i mod n

	If we have n procs, then at iteration i 

	*/
	for(i=0;i<total-1;i++){
		if (my_id < nprocs-1){
			pos = my_id - i;
			if (pos < 0) pos += (nprocs-1);
			if (pos == 0){
				p = nprocs-1;
			} else {
				p = nprocs - 1 - pos + i;
				if(p > (nprocs - 2)){
					p -= nprocs-1;
				}
			}
		} else {
			p = i;
		}
		nghbors[i+1] = p;
	}
	return(total);
}

int xor_part(int my_id, int nprocs, int **partners){
	int total, levels;
	int i;
	int p;
	int *nghbors;
	double num = (double) nprocs;
	double lev;
	/*
	We need an even number to make this work right, so we'll round up.
	*/
	
	num = log(num)/log(2.0);
	lev = ceil(num);
	levels = ( int ) lev;
	total = 1 << levels;
	/*
	Get the space for the neighbors array.
	*/

	nghbors = (int *)calloc(sizeof(int),total+1);
	partners[0] = nghbors;

	/*
	For this we just xor the iteration with the rank.
	*/

	for(i=0;i<total;i++){
		p = (my_id ^ i);
		nghbors[i] = p;
	}
	return(total);
}
