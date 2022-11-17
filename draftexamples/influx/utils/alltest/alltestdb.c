#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include <unistd.h>

#include "mpi.h"
#include "partners.h"

#include <time.h>

#define BW_DATA_SIZE	(2048*1000)
#define LAT_DATA_SIZE   (8)
#define NUM_TESTS       (10)
#define TAG		(0)
#define PNAMELEN        (128)

int main(int argc, char *argv[])
{
	int i, j, k, in, p, total, steps;
	int *partners;
	int ret, rank, size;
	int pretest = 0;
	int reverse = 0;
	int rankStartStats = 0;
	int printStartStats = 0;
	int printMaxMin = 0;
	int startOnly = 0;
	
	int (*getPartners)(int, int, int**) = &full_blown;
	int numTests = NUM_TESTS;
	int latTests = NUM_TESTS * 30;
	int bwDataSize = BW_DATA_SIZE;
	int latDataSize = LAT_DATA_SIZE;
	time_t ts_start, ts_end;

	FILE *out;
	char filename[128] = "at_out.3d";
	char myhost[PNAMELEN];

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
	struct dii {
		double d;
		char *p1;
		char *p2;
	} max_bw, min_bw, max_lat, min_lat, med_bw, med_lat;

	MPI_Status status;
	MPI_Request sendReq, recvReq;
	MPI_Comm comm = MPI_COMM_WORLD;

	double ts, BWtime, pipeTime;
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
		else if (strcmp(argv[i],"-st") == 0){
			printStartStats = 1;
		}
		else if (strcmp(argv[i],"-rst") == 0){
			rankStartStats=1;
			printStartStats=1;
		}
		else if (strcmp(argv[i],"-mm") == 0){
			printMaxMin = 1;
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
		else if (strcmp(argv[i],"-startonly") == 0){
			startOnly = 1;
			printStartStats = 1;
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
	/*
	 * If we're rank 0, we'll need an output file.
	 */
	if(startOnly == 1){
		MPI_Finalize();
		return(0);
	}
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
	hostlist = (char *) calloc(sizeof(char), size * total * PNAMELEN);

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
			} else {
				printf("%d %d to %d A setup\n",rank,i,p);
				MPI_Send_init(sendBuff, latDataSize, MPI_CHAR, p,
					      TAG, comm, &sendReq);
				MPI_Recv_init(recvBuff, latDataSize, MPI_CHAR, p,
					      TAG, comm, &recvReq);
	
				printf("%d %d to %d B barrier\n",rank,i,p);
				MPI_Barrier(comm);
				for (j = 0; j < 5; j++) {
					printf("%d %d to %d C start\n",rank,i,p);
					MPI_Start(&sendReq);
					MPI_Start(&recvReq);
	
					printf("%d %d to %d D wait\n",rank,i,p);
					MPI_Wait(&sendReq, &status);
					MPI_Wait(&recvReq, &status);
				}
				printf("%d %d to %d E wait\n",rank,i,p);
				MPI_Request_free(&sendReq);
				MPI_Request_free(&recvReq);
				printf("%d %d to %d F done\n",rank,i,p);
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
		} else if (p >= rank) {
			MPI_Send_init(sendBuff, bwDataSize, MPI_CHAR, p,
				      TAG, comm, &sendReq);
			MPI_Recv_init(recvBuff, bwDataSize, MPI_CHAR, p,
				      TAG, comm, &recvReq);

			MPI_Barrier(comm);

			/*
			 * I'm only timing the send and rec, not the whole
			 * setup and teardown. 
			 */
			ts = MPI_Wtime();
			for (j = 0; j < numTests; j++) {
				MPI_Start(&sendReq);
				MPI_Start(&recvReq);

				MPI_Wait(&sendReq, &status);
				MPI_Wait(&recvReq, &status);
			}
			BWtime = MPI_Wtime() - ts;

			MPI_Request_free(&sendReq);
			MPI_Request_free(&recvReq);
			MPI_Send_init(sendBuff, latDataSize, MPI_CHAR, p,
				      TAG, comm, &sendReq);
			MPI_Recv_init(recvBuff, latDataSize, MPI_CHAR, p,
				      TAG, comm, &recvReq);

			MPI_Barrier(comm);
			/*
			 * For this half of the calculation, I'm
			 * going to wait 20 itterations before I
			 * start using the data, just in case
			 * there's a startup cost for the initial
			 * communications.
			 */
			for (j = 0; j < 20; j++) {
				MPI_Start(&sendReq);
				MPI_Start(&recvReq);

				MPI_Wait(&sendReq, &status);
				MPI_Wait(&recvReq, &status);
			}
			ts=MPI_Wtime();
			for (; j < latTests; j++) {
				MPI_Start(&sendReq);
				MPI_Start(&recvReq);

				MPI_Wait(&sendReq, &status);
				MPI_Wait(&recvReq, &status);
			}
			pipeTime = (MPI_Wtime() - ts);

			MPI_Request_free(&sendReq);
			MPI_Request_free(&recvReq);
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
			MPI_Send_init(sendBuff, bwDataSize, MPI_CHAR, p,
				      TAG, comm, &sendReq);
			MPI_Recv_init(recvBuff, bwDataSize, MPI_CHAR, p,
				      TAG, comm, &recvReq);

			MPI_Barrier(comm);
			ts = MPI_Wtime();
			for (j = 0; j < numTests; j++) {
				MPI_Start(&recvReq);
				MPI_Start(&sendReq);

				MPI_Wait(&recvReq, &status);
				MPI_Wait(&sendReq, &status);
			}
			BWtime = MPI_Wtime() - ts;
			MPI_Request_free(&sendReq);
			MPI_Request_free(&recvReq);
			MPI_Send_init(sendBuff, latDataSize, MPI_CHAR, p,
				      TAG, comm, &sendReq);
			MPI_Recv_init(recvBuff, latDataSize, MPI_CHAR, p,
				      TAG, comm, &recvReq);

			MPI_Barrier(comm);
			ts = MPI_Wtime();
			for (j = 0; j < latTests; j++) {
				MPI_Start(&recvReq);
				MPI_Start(&sendReq);

				MPI_Wait(&recvReq, &status);
				MPI_Wait(&sendReq, &status);
			}
			pipeTime = (MPI_Wtime() - ts);
			MPI_Request_free(&sendReq);
			MPI_Request_free(&recvReq);
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
	MPI_Gather(myhost, PNAMELEN, MPI_CHAR, hostlist, PNAMELEN, MPI_CHAR, 0,
		   comm);
	if (rank == 0) {
		printf("Writing output to file\n");
		fflush(stdout);
	}

	/*
	 * print out what we've found.
	 */
	max_bw.d=0;
	min_bw.d=9e+80;
	max_lat.d=0;
	min_lat.d=9e+80;
	if (rank == 0) {
		/*
		 * Print the file header
		 */
		fprintf(out, "X Y Bandwidth Latency Iter HostX HostY\n");
		for (i = 0; i < size; i++) {
			hlpX = hostlist + i*PNAMELEN;
			fprintf(out, "\n");
			for (j = 0; j < size; j++) {
				hlpY = hostlist + j*PNAMELEN;
				k = i * total + j;
				fprintf(out, "%d %d %1.02f %1.02f %d %s %s\n", i,
					j, bw[k], lat[k], allturn[k],
					hlpX, hlpY);
				if (strcmp(hlpX, hlpY)){
					if (bw[k] > max_bw.d){
						max_bw.d = bw[k];
						max_bw.p1=hlpX;
						max_bw.p2=hlpY;
					}
					if (bw[k] < min_bw.d){
						min_bw.d = bw[k];
						min_bw.p1 = hlpX;
						min_bw.p2 = hlpY;
					}
					if (lat[k] > max_lat.d){
						max_lat.d = lat[k];
						max_lat.p1 = hlpX;
						max_lat.p2 = hlpY;
					}
					if (lat[k] < min_lat.d){
						min_lat.d = lat[k];
						min_lat.p1 = hlpX;
						min_lat.p2 = hlpY;
					}
				}
			}
		}
		fflush(out);
		if (printMaxMin){
			printf("Max Latency  %2.04f [%s to %s]\n", max_lat.d, max_lat.p1, max_lat.p2);
			printf("Min Latency  %2.04f [%s to %s]\n", min_lat.d, min_lat.p1, min_lat.p2);
			printf("Max BW       %2.04f [%s to %s]\n", max_bw.d, max_bw.p1, max_bw.p2);
			printf("Min BW       %2.04f [%s to %s]\n", min_bw.d, min_bw.p1, min_bw.p2);
			now = time((time_t *)NULL);
			printf("Done at %s", asctime(localtime(&now)));
		}
	}
	
	MPI_Finalize();

	return (0);
}
