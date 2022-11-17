clc,clear

setenv LD_LIBRARY_PATH /usr/lib64:LD_LIBRARY_PATH

Cluster=parcluster('ACI'); 
Cluster.ResourceTemplate= '-A open -l nodes=1:ppn=20 -l walltime=5:00 -l pmem=1gb';
jj = batch(Cluster, 'testpar','pool',19);

%jj = batch(Cluster, 'testpar');

wait(jj)
diary(jj)
load(jj)


