#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include <unistd.h>

#include "mpi.h"
#include <time.h>

#define TAG		(0)
#define PNAMELEN        (128)

int main(int argc, char *argv[])
{
	int i, j, k, in, p, total, steps;
	int ret, rank, size;
	int rankStartStats = 0;
	int printStartStats = 1;
	int printMaxMin = 0;
	int startOnly = 0;
	
	time_t ts_start, ts_end;

	FILE *out;
	char myhost[PNAMELEN];
	int num_MIC;

	/*
	Setup some stuff for measuring job startup and MPI_Init time
	*/
        time_t now;
	struct timeval tv1, tv2;
	struct d_int {
		double ts;
		int    loc;
	} in1, in2, ind, min1, min2, max1, max2, mindiff, maxdiff;
	struct d_int *gather, sndbuf[3], *g;

	MPI_Status status;
	MPI_Request sendReq, recvReq;
	MPI_Comm comm = MPI_COMM_WORLD;

	double ts;
	double t_start, t_end;
	double *bw, *lat, *bandwidth, *latency;
	char *hostlist, *hlpX, *hlpY;
	int iX, iY;
	int *turn,*allturn;

	char *sendBuff, *recvBuff;

	/*
	First get the current time, so we have a reference.
	Get the time immediately after MPI_Init too.
	*/
	gettimeofday(&tv1,NULL);
	MPI_Init(&argc, &argv);
	gettimeofday(&tv2,NULL);
	MPI_Comm_size(comm, &size);
	MPI_Comm_rank(comm, &rank);
	gethostname(myhost,PNAMELEN);

	num_MIC = _Offload_number_of_devices();
	if ( num_MIC != 2 ){
		printf("host=%s RANK=%d MIC=%d\n", myhost, rank, num_MIC);
	}

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
		if (strcmp(argv[i],"-rst") == 0){
			rankStartStats=1;
		}
		else
		{
			fprintf(stderr, "Error: I don't understand %s\n", argv[i]);
			exit(-2);
		}
	}
	if(printStartStats){
		/*
		Calculate the time differences to compare between ranks.
		*/
		sndbuf[0].ts = (double) tv1.tv_sec + ((double) tv1.tv_usec)/1000000.0;
		sndbuf[1].ts = (double) tv2.tv_sec + ((double) tv2.tv_usec)/1000000.0;
		sndbuf[2].ts = sndbuf[1].ts - sndbuf[0].ts;
		sndbuf[0].loc = rank;
		sndbuf[1].loc = rank;
		sndbuf[2].loc = rank;
		/*
		Gather the startup info from all the nodes
		*/
		MPI_Reduce(&sndbuf[0], &min1, 1, MPI_DOUBLE_INT, MPI_MINLOC, 
				0, MPI_COMM_WORLD);
		MPI_Reduce(&sndbuf[0], &max1, 1, MPI_DOUBLE_INT, MPI_MAXLOC, 
				0, MPI_COMM_WORLD);
		MPI_Reduce(&sndbuf[1], &min2, 1, MPI_DOUBLE_INT, MPI_MINLOC, 
				0, MPI_COMM_WORLD);
		MPI_Reduce(&sndbuf[1], &max2, 1, MPI_DOUBLE_INT, MPI_MAXLOC, 
				0, MPI_COMM_WORLD);
		MPI_Reduce(&sndbuf[2], &mindiff, 1, MPI_DOUBLE_INT, MPI_MINLOC, 
				0, MPI_COMM_WORLD);
		MPI_Reduce(&sndbuf[2], &maxdiff, 1, MPI_DOUBLE_INT, MPI_MAXLOC, 
				0, MPI_COMM_WORLD);
		gather = calloc(size, sizeof sndbuf);
		MPI_Gather(sndbuf, 3, MPI_DOUBLE_INT, gather, 3, MPI_DOUBLE_INT,
				0, MPI_COMM_WORLD);
		/*
		Print out stats
		*/
		if(rank == 0){
			if(rankStartStats){
				printf("[Rank] exec-Diff Init-Diff time-Diff\n");
				for(i=0;i<size;i++){
					g = gather + i*3;
					printf("[%d] %2.04f %2.04f %2.04f\n",
						i, g[0].ts-min1.ts,g[1].ts-min2.ts,
						g[2].ts-mindiff.ts);
				}
			}
			printf("Earliest Start %2.04f [%d]\n", min1.ts, min1.loc);
			printf("Latest Start   %2.04f [%d]\n", max1.ts, max1.loc);
			printf("First MPI_Init %2.04f [%d]\n", min2.ts, min2.loc);
			printf("Last  MPI_Init %2.04f [%d]\n", max2.ts, max2.loc);
			printf("Quickest Init  %2.04f [%d]\n", mindiff.ts, mindiff.loc);
			printf("Slowest Init   %2.04f [%d]\n", maxdiff.ts, maxdiff.loc);
			printf("Max Init Time  %2.04f [%d to %d]\n", 
				max2.ts-min1.ts, min1.loc, max2.loc);
			now = time((time_t *)NULL);
			printf("Done at %s", asctime(localtime(&now)));
		}
	}

	MPI_Finalize();

	return (0);
}
