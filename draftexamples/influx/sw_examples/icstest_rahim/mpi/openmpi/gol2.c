//rkc10



#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/time.h>
#include <time.h>
#include <omp.h>

#define USE_MPI 1

#if USE_MPI
#include <mpi.h>
#endif

// timer to record the time 
static double timer() {
    struct timeval tp;
    gettimeofday(&tp, NULL);
    return ((double) (tp.tv_sec) + 1e-6 * tp.tv_usec);
}



int main(int argc, char **argv) {

    int rank, num_tasks;
	
	double comm_Time = 0;
	double temp_Time = 0;

#if USE_MPI
    MPI_Init(&argc, &argv);     
    MPI_Comm_size(MPI_COMM_WORLD, &num_tasks);  
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);   
//    printf("Hello world from rank %3d of %3d\n", rank, num_tasks);
#else
    rank = 0;
    num_tasks = 1;
#endif

    if (argc != 3) {
        if (rank == 0) {
            fprintf(stderr, "%s <m> <k>\n", argv[0]);
            fprintf(stderr, "Program for parallel Game of Life\n");
            fprintf(stderr, "with 1D grid partitioning\n");
            fprintf(stderr, "<m>: grid dimension (an mxm grid is created)\n");
            fprintf(stderr, "<k>: number of time steps\n");
            fprintf(stderr, "(initial pattern specified inside code)\n");
#if USE_MPI
            MPI_Abort(MPI_COMM_WORLD, 1);
#else
            exit(1);
#endif
        }
    }

    int m, k;

    m = atoi(argv[1]);  //grid dimension
    assert(m > 2);
    assert(m <= 10000);

    k = atoi(argv[2]);  //grid time steps
    assert(k > 0);
    assert(k <= 1000);
    //if m and k are out of bound, then the program will terminate here.

    /* ensure that m is a multiple of num_tasks */
    m = (m/num_tasks) * num_tasks;

    int m_p = (m/num_tasks);    //dimension of one side of block in each task. After parallel, each block has a dimension of mp*m.

    if (rank == 0) {
        fprintf(stderr, "Using m: %d, m_p: %d, k: %d\n", m, m_p, k);
        fprintf(stderr, "Requires %3.6lf MB of memory per task\n",
                ((2*4.0*m_p)*m/1e6));
    }

    int *grid_current;
    int *grid_next;

    grid_current = (int *) malloc(m_p * m * sizeof(int));
    assert(grid_current != 0);

    grid_next = (int *) malloc(m_p * m * sizeof(int));
    assert(grid_next != 0);

    int i, j, t;

#ifdef _OPENMP
#pragma omp parallel for private(i,j)
#endif

    for (i=0; i<m_p; i++) {
        for (j=0; j<m; j++) {
            grid_current[i*m+j] = 0;
            grid_next[i*m+j] = 0;
        }
    }

    assert((m*m_p/2 + m/2 + 3) < m_p*m);
    grid_current[m*m_p/2 + m/2 + 0] = 1;
    grid_current[m*m_p/2 + m/2 + 1] = 1;
    grid_current[m*m_p/2 + m/2 + 2] = 1;
    grid_current[m*m_p/2 + m/2 + 3] = 1;


#if USE_MPI
    MPI_Barrier(MPI_COMM_WORLD);
#endif

/*start time clock here*/
    double elt = 0.0;
    if (rank == 0)
        elt = timer();

#if USE_MPI
MPI_Status status;
        If rank = 0, then i should ranging from 1 to mp-1, for i = mp-1, the 3 i+1 terms should coming from next task.
        if rank = num_tasks-1, then i should ranging from 0 to mp-2, for i=0, the 3 i-1 terms should coming from previous task.
        in other job, i should ranging from 0 to mp-1. at i=0, three i-1 terms should coming from previous task; at i=mp-1, three i+1 terms should coming from next task. */

    if (rank == 0) {
    for (t=0; t<k; t++) {
        for (i=1; i<m_p-1; i++) {
            for (j=1; j<m-1; j++) {
                int prev_state = grid_current[i*m+j];
                int num_alive  =
                                grid_current[(i  )*m+j-1] +
                                grid_current[(i  )*m+j+1] +
                                grid_current[(i-1)*m+j-1] +
                                grid_current[(i-1)*m+j  ] +
                                grid_current[(i-1)*m+j+1] +
                                grid_current[(i+1)*m+j-1] +
                                grid_current[(i+1)*m+j  ] +
                                grid_current[(i+1)*m+j+1];
                grid_next[i*m+j] = prev_state * ((num_alive == 2) + (num_alive == 3)) + (1 - prev_state) * (num_alive == 3);
            }
        }
        for (i=m_p-1;i<m_p;i++){
            int *rec_current;
            int *send_current;

            rec_current = (int *) malloc(m * sizeof(int));
            send_current = (int *) malloc(m * sizeof(int));
            
            for (j=0; j<m; j++) {
                 send_current[j] = grid_current[(i )*m+j];
                 rec_current[j] = grid_current[(i+1)*m+j];
            }

temp_Time = MPI_Wtime();
	    MPI_Sendrecv(send_current,m,MPI_INT,rank+1,20,rec_current,m,MPI_INT,rank+1,20,MPI_COMM_WORLD,&status);
temp_Time = MPI_Wtime() - temp_Time;
comm_Time = comm_Time + temp_Time;


            for (j=1; j<m-1; j++) {
                int prev_state = grid_current[i*m+j];
                int num_alive  =
                                grid_current[(i  )*m+j-1] +
                                grid_current[(i  )*m+j+1] +
                                grid_current[(i-1)*m+j-1] +
                                grid_current[(i-1)*m+j  ] +
                                grid_current[(i-1)*m+j+1] +
                                rec_current[j-1] +
                                rec_current[j  ] +
                                rec_current[j+1];
                grid_next[i*m+j] = prev_state * ((num_alive == 2) + (num_alive == 3)) + (1 - prev_state) * (num_alive == 3);
            }
        }
        // swap
        int *grid_tmp  = grid_next;
        grid_next = grid_current;
        grid_current = grid_tmp;
    }
    }

    if (rank == num_tasks-1) {
    for (t=0; t<k; t++) {
        for (i=0;i<1;i++){
            int *rec_current;
            int *send_current;

            rec_current = (int *) malloc(m * sizeof(int));
            send_current = (int *) malloc(m * sizeof(int));
			
            for (j=0; j<m; j++) {
                 send_current[j] = grid_current[(i )*m+j];
            }

temp_Time = MPI_Wtime();
            MPI_Sendrecv(send_current,m,MPI_INT,rank-1,20,rec_current,m,MPI_INT,rank-1,20,MPI_COMM_WORLD,&status);
temp_Time = MPI_Wtime() - temp_Time;
comm_Time = comm_Time + temp_Time;

            for (j=1; j<m-1; j++) {
                int prev_state = grid_current[i*m+j];
                int num_alive  =
                                grid_current[(i  )*m+j-1] +
                                grid_current[(i  )*m+j+1] +
                                grid_current[(i+1)*m+j-1] +
                                grid_current[(i+1)*m+j  ] +
                                grid_current[(i+1)*m+j+1] +
                                rec_current[j-1] +
                                rec_current[j  ] +
                                rec_current[j+1];
                grid_next[i*m+j] = prev_state * ((num_alive == 2) + (num_alive == 3)) + (1 - prev_state) * (num_alive == 3);
            }
        }
        for (i=1; i<m_p-1; i++) {
            for (j=1; j<m-1; j++) {
                int prev_state = grid_current[i*m+j];
                int num_alive  =
                                grid_current[(i  )*m+j-1] +
                                grid_current[(i  )*m+j+1] +
                                grid_current[(i-1)*m+j-1] +
                                grid_current[(i-1)*m+j  ] +
                                grid_current[(i-1)*m+j+1] +
                                grid_current[(i+1)*m+j-1] +
                                grid_current[(i+1)*m+j  ] +
                                grid_current[(i+1)*m+j+1];
                grid_next[i*m+j] = prev_state * ((num_alive == 2) + (num_alive == 3)) + (1 - prev_state) * (num_alive == 3);
            }
        }

        int *grid_tmp  = grid_next;
        grid_next = grid_current;
        grid_current = grid_tmp;
    }}
    if (rank != num_tasks-1 && rank != 0) {
    for (t=0; t<k; t++) {
        for (i=0;i<1;i++){
            int *rec_current;
            int *send_current;

            rec_current = (int *) malloc(m * sizeof(int));
            send_current = (int *) malloc(m * sizeof(int));
            for (j=0; j<m; j++) {
                 send_current[j] = grid_current[(i )*m+j];
            }

temp_Time = MPI_Wtime();
            MPI_Sendrecv(send_current,m,MPI_INT,rank-1,20,rec_current,m,MPI_INT,rank-1,20,MPI_COMM_WORLD,&status);
temp_Time = MPI_Wtime() - temp_Time;
comm_Time = comm_Time + temp_Time;

            for (j=1; j<m-1; j++) {
                int prev_state = grid_current[i*m+j];
                int num_alive  =
                                grid_current[(i  )*m+j-1] +
                                grid_current[(i  )*m+j+1] +
                                grid_current[(i+1)*m+j-1] +
                                grid_current[(i+1)*m+j  ] +
                                grid_current[(i+1)*m+j+1] +
                                rec_current[j-1] +
                                rec_current[j  ] +
                                rec_current[j+1];
                grid_next[i*m+j] = prev_state * ((num_alive == 2) + (num_alive == 3)) + (1 - prev_state) * (num_alive == 3);
            }
        }
        for (i=1; i<m_p-1; i++) {
            for (j=1; j<m-1; j++) {
                int prev_state = grid_current[i*m+j];
                int num_alive  =
                                grid_current[(i  )*m+j-1] +
                                grid_current[(i  )*m+j+1] +
                                grid_current[(i-1)*m+j-1] +
                                grid_current[(i-1)*m+j  ] +
                                grid_current[(i-1)*m+j+1] +
                                grid_current[(i+1)*m+j-1] +
                                grid_current[(i+1)*m+j  ] +
                                grid_current[(i+1)*m+j+1];
                grid_next[i*m+j] = prev_state * ((num_alive == 2) + (num_alive == 3)) + (1 - prev_state) * (num_alive == 3);
            }
        }
        for (i=m_p-1;i<m_p;i++){
            int *rec_current;
            int *send_current;

            rec_current = (int *) malloc(m * sizeof(int));
            send_current = (int *) malloc(m * sizeof(int));
            for (j=0; j<m; j++) {
                 send_current[j] = grid_current[(i )*m+j];
            }

temp_Time = MPI_Wtime();
            MPI_Sendrecv(send_current,m,MPI_INT,rank+1,20,rec_current,m,MPI_INT,rank+1,20,MPI_COMM_WORLD,&status);
temp_Time = MPI_Wtime() - temp_Time;
comm_Time = comm_Time + temp_Time;
			
            for (j=1; j<m-1; j++) {
                int prev_state = grid_current[i*m+j];
                int num_alive  =
                                grid_current[(i  )*m+j-1] +
                                grid_current[(i  )*m+j+1] +
                                grid_current[(i-1)*m+j-1] +
                                grid_current[(i-1)*m+j  ] +
                                grid_current[(i-1)*m+j+1] +
                                rec_current[j-1] +
                                rec_current[j  ] +
                                rec_current[j+1];
                grid_next[i*m+j] = prev_state * ((num_alive == 2) + (num_alive == 3)) + (1 - prev_state) * (num_alive == 3);
            }
        }
        int *grid_tmp  = grid_next;
        grid_next = grid_current;
        grid_current = grid_tmp;
    }
    }
#else

    /* serial code */
    for (t=0; t<k; t++) {
        for (i=1; i<m-1; i++) {
            for (j=1; j<m-1; j++) {
                int prev_state = grid_current[i*m+j];
                int num_alive  =
                                grid_current[(i  )*m+j-1] +
                                grid_current[(i  )*m+j+1] +
                                grid_current[(i-1)*m+j-1] +
                                grid_current[(i-1)*m+j  ] +
                                grid_current[(i-1)*m+j+1] +
                                grid_current[(i+1)*m+j-1] +
                                grid_current[(i+1)*m+j  ] +
                                grid_current[(i+1)*m+j+1];

                grid_next[i*m+j] = prev_state * ((num_alive == 2) + (num_alive == 3)) + (1 - prev_state) * (num_alive == 3);
            }
        }
        int *grid_tmp  = grid_next;
        grid_next = grid_current;
        grid_current = grid_tmp;
    }
#endif

    if (rank == 0)
        elt = timer() - elt;

    /* Verify */
    int verify_failed = 0;

    if (verify_failed) {
        fprintf(stderr, "ERROR: rank %d, verification failed, exiting!\n", rank);
#if USE_MPI
        MPI_Abort(MPI_COMM_WORLD, 2);
#else
        exit(2);
#endif
    }

    if (rank == 0) {
        fprintf(stderr, "Time taken: %3.3lf s.\n", elt);
		fprintf(stderr, "Comm time taken: %3.3lf s.\n", comm_Time);
        fprintf(stderr, "Performance: %3.3lf billion cell updates/s\n",
                (1.0*m*m)*k/(elt*1e9));
    }

    /* free memory */
    free(grid_current); free(grid_next);

    /* Shut down MPI */
#if USE_MPI
    MPI_Finalize();
#endif

    return 0;
}


