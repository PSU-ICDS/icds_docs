#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>

#include "mpi.h"
#include "partners.h"

#include <time.h>

#define BW_DATA_SIZE	(2048*10000)
#define LAT_DATA_SIZE   (8)
#define NUM_TESTS       (10)
#define TAG		(31043)


int main(int argc, char *argv[])
{
	int i, j, k, in, p, total, steps;
	int *partners;
	int ret, rank, size;
	int pretest = 0;
	int reverse = 0;
	
	int (*getPartners)(int, int, int**) = &full_blown;
	int numTests = NUM_TESTS;
	int latTests = NUM_TESTS * 30;
	int bwDataSize = BW_DATA_SIZE;
	int latDataSize = LAT_DATA_SIZE;
	time_t ts_start, ts_end;

	FILE *out;
	char filename[128] = "at_out.3d";

	MPI_Status status;
	MPI_Request sendReq, recvReq;
	MPI_Comm comm = MPI_COMM_WORLD;

	double ts, BWtime, pipeTime;
	double t_start, t_end;
	double *bw, *lat, *bandwidth, *latency;
	int *turn,*allturn;

	char *sendBuff, *recvBuff;

	MPI_Init(&argc, &argv);
	MPI_Comm_size(comm, &size);
	MPI_Comm_rank(comm, &rank);

	/*
	 * If we don't have more than 1 task, it isn't going to be worth
	 * running 
	 */

	if (size < 2) {
		printf("This program requires more than one process!\n");
		fflush(stdout);
		return (0);
	};

	for(i = 1; i < argc; i++) {
		if (strcmp(argv[i],"-fb") == 0){
			getPartners = &full_blown;
		} 
		else if (strcmp(argv[i],"-sb") == 0){
			getPartners = &slide_by;
		}
		else if (strcmp(argv[i],"-xo") == 0){
			getPartners = &xor_part;
		}
		else if (strcmp(argv[i],"-fn") == 0){
			strcpy(filename, argv[i+1]);
			i++;
		}
		else if (strcmp(argv[i],"-pre") == 0){
			pretest = 1;
		}
		else if (strcmp(argv[i],"-rv") == 0){
			reverse = 1;
		}
		else
		{
			fprintf(stderr, "Error: I don't understand %s\n", argv[i]);
			exit(-2);
		}
	}
	/*
	 * If we're rank 0, we'll need an output file.
	 */
	if(rank == 0){
		printf("Opening '%s' for output...\n", filename);
		fflush(stdout);
		out = fopen(filename, "w");
		if(out == NULL){
			fprintf(stderr, "Failed to open output '%s'", filename);
			exit(1);
		}
	}
		
	/*
	 * Fill the partner array 
	 */
	steps = getPartners(rank, size, &partners);
	if(reverse) for(i = 0, j = steps - 1; i < (steps / 2); i++, j--)
	{
		p = partners[i];
		partners[i] = partners[j];
		partners[j] = p;
	}

	/*
	 * Make sure there's enough space for storage... 
	 */
	total = steps + 2;

	/*
	 * Allocate memory for send recv stuff. 
	 */
	sendBuff = (char *) malloc(bwDataSize);
	recvBuff = (char *) malloc(bwDataSize);

	/*
	 * Allocate space to collect results. 
	 */
	bandwidth = (double *) calloc(sizeof(double), total);
	latency = (double *) calloc(sizeof(double), total);
	turn = (int *) calloc(sizeof(int), total);

	/*
	 * For rank 0, allocate something for collecting everything. 
	 */
	bw = (double *) calloc(sizeof(double), size * total);
	lat = (double *) calloc(sizeof(double), size * total);
	allturn = (int *) calloc(sizeof(int), size * total);

	/*
	 * Some implementations of MPI don't allocate connections
	 * until they're needed.  This may cause a latency increase
	 * for measurements made later in the run.  This section
	 * attempts to establish all communication pairs up-front
	 * to avoid the penalty later on.
	 */
	if (pretest){
		for (i = 0; i < steps; i++) {
			p = partners[i];
			if (rank == 0) {
				printf("Starting pre %d\n", i);
				fflush(stdout);
			}
			if (p >= size){
				MPI_Barrier(comm);
			} else if (p == rank) {
				MPI_Barrier(comm);
			} else {
				MPI_Barrier(comm);
				for (j = 0; j < 5; j++) {
					MPI_Send(sendBuff, latDataSize, MPI_CHAR, p,
						 TAG, comm);
					MPI_Recv(recvBuff, latDataSize, MPI_CHAR, p,
						 TAG, comm, &status);
				}
			}
		}
	}

	ts_start = time((time_t *) NULL);
	t_start = MPI_Wtime();
	for (i = 0; i < steps; i++) {
		p = partners[i];
		if (rank == 0) {
			printf("Starting ittr %d\n", i);
			fflush(stdout);
		}
		if (p >= size) {
			/*
			 * If we're trying to communicate with a partner
			 * above the size of our cluster, something's wrong.
			 */
			MPI_Barrier(comm);
			MPI_Barrier(comm);
		} else if (p == rank) {
			/*
			 * Hmmm..... I'm not sure how to test this one... 
			 */
			MPI_Barrier(comm);
			MPI_Barrier(comm);
		} else if (p > rank) {
			MPI_Barrier(comm);

			/*
			 * I'm only timing the send and rec, not the whole
			 * setup and teardown. 
			 */
			ts = MPI_Wtime();
			for (j = 0; j < numTests; j++) {
				MPI_Send(sendBuff, bwDataSize, MPI_CHAR, p,
					 TAG, comm);
				MPI_Recv(recvBuff, bwDataSize, MPI_CHAR, p,
					 TAG, comm, &status);
			}
			BWtime = MPI_Wtime() - ts;

			MPI_Barrier(comm);
			/*
			 * For this half of the calculation, I'm
			 * going to wait 20 itterations before I
			 * start using the data, just in case
			 * there's a startup cost for the initial
			 * communications.
			 */
			for (j = 0; j < 20; j++) {
				MPI_Send(sendBuff, latDataSize, MPI_CHAR, p,
					 TAG, comm);
				MPI_Recv(recvBuff, latDataSize, MPI_CHAR, p,
					 TAG, comm, &status);
			}
			ts=MPI_Wtime();
			for (; j < latTests; j++) {
				MPI_Send(sendBuff, latDataSize, MPI_CHAR, p,
					 TAG, comm);
				MPI_Recv(recvBuff, latDataSize, MPI_CHAR, p,
					 TAG, comm, &status);
			}
			pipeTime = (MPI_Wtime() - ts);
			/*
			 * I'm using the 1/2 round trip time. Thus the 2.0
			 * in the latency calculation
			 * 
			 * The bandwidth goes out and comes back, so I
			 * count it twice for each test. 
			 */
			latency[p] = pipeTime / 2.0 / (latTests-20) * 1.e6;
			bandwidth[p] =
			    2 * numTests * bwDataSize / BWtime / 1024 / 1024;
			turn[p] = i;
		} else if (p < rank) {
			/*
			 * If our partner is lower in rank than us, they'll
			 * do the send first and then the receive. 
			 */
			MPI_Barrier(comm);
			ts = MPI_Wtime();
			for (j = 0; j < numTests; j++) {
				MPI_Recv(recvBuff, bwDataSize, MPI_CHAR, p,
					 TAG, comm, &status);
				MPI_Send(sendBuff, bwDataSize, MPI_CHAR, p,
					 TAG, comm);
			}
			BWtime = MPI_Wtime() - ts;
			MPI_Barrier(comm);
			ts = MPI_Wtime();
			for (j = 0; j < latTests; j++) {
				MPI_Recv(recvBuff, latDataSize, MPI_CHAR, p,
					 TAG, comm, &status);
				MPI_Send(sendBuff, latDataSize, MPI_CHAR, p,
					 TAG, comm);
			}
			pipeTime = (MPI_Wtime() - ts);
			latency[p] = pipeTime / 2.0 / latTests * 1.e6;
			bandwidth[p] =
			    2.0 * numTests * bwDataSize / BWtime / 1024 /
			    1024;
			turn[p] = i;
		}

	}
	ts_end = time((time_t *) NULL);
	t_end = MPI_Wtime();
	free(recvBuff);
	free(sendBuff);

	/*
	 * Gather all of the info from the different nodes.
	 */

	if (rank == 0) {
		printf("Collecting bandwidth info\n");
	}
	MPI_Gather(bandwidth, total, MPI_DOUBLE, bw, total, MPI_DOUBLE, 0,
		   comm);
	if (rank == 0) {
		printf("Collecting latency info\n");
	}
	MPI_Gather(latency, total, MPI_DOUBLE, lat, total, MPI_DOUBLE, 0,
		   comm);
	if (rank == 0) {
		printf("Collecting turn info\n");
	}
	MPI_Gather(turn, total, MPI_INT, allturn, total, MPI_INT, 0,
		   comm);
	if (rank == 0) {
		printf("Writing output to file\n");
		fflush(stdout);
	}

	/*
	 * print out what we've found.
	 */
	if (rank == 0) {
		/*
		 * Print the file header
		 */
		fprintf(out, "X Y Bandwidth Latency Iter\n");
		for (i = 0; i < size; i++) {
			fprintf(out, "\n");
			for (j = 0; j < size; j++) {
				k = i * total + j;
				fprintf(out, "%d %d %1.02f %1.02f %d\n", i,
					j, bw[k], lat[k], allturn[k]);
			}
		}
		fflush(out);
	}
	MPI_Finalize();

	return (0);
}
