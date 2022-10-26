% Run code on the ACI cluster - use many workers

% Set environmental variables (libraries)
setenv LD_LIBRARY_PATH /usr/lib64:LD_LIBRARY_PATH

% Define cluster
MyCluster = parcluster('local');

% Define Resources
MyCluster.ResourceTemplate = '-A open -l nodes=1:ppn=1 -l walltime=10:00';

% Run code
j = batch(MyCluster, 'diarytest', 'pool', 99);

% Wait for the job to finish
wait(j)

% Display diary
diary(j)

% get the results
load(j)

% End Code
