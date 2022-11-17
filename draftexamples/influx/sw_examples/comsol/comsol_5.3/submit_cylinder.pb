#PBS -l nodes=3:ppn=10
#PBS -l walltime=3:00:00
#PBS -l pmem=2gb
#PBS -A open
#PBS -j oe
# Get started
echo " "
echo "Job started on `hostname` at `date`"
echo " "

# Load in module 
module load comsol/5.3
echo "comsol is loaded"
# Go to the correct place
cd $PBS_O_WORKDIR
echo "loaded to the pwd"
# Run the job
#export I_MPI_HYDRA_BOOTSTRAP=pbsdsh
comsol batch -f $PBS_NODEFILE -nn 3 -np 10 -inputfile cylinder_flow5.3.mph -outputfile $PBS_O_WORKDIR/sample_output.mph -batchlog log.txt

# Finish up
echo " "
echo "Job Ended at `date`"
echo " "
