### Interactive Jobs

Interactive command line sessions are helpful for more intensive computations that are not appropriate 
for the submit nodes, such as testing workflows, interactive data wrangling, or compiling software.

To allocate an interactive session, the `salloc` command is combined with [Slurm resource directives](slurm.md) 
to request desired hardware.

For example, to work interactively on a compute node with a single processor core for one hour, use the following command:

```
$ salloc --nodes=1 --ntasks=1 --mem=1G --time=01:00:00
```

Or, using short options:

```
$ salloc -N 1 -n 1 --mem 1G -t 1:00:00
```

The above commands submit a request to the scheduler to queue an interactive job. When the 
resources become available and the job is launched, an active prompt will return, now displaying the name 
of the compute node in place of the previous submit node.  

This session is terminated either when the time limit is reached or when the `exit` command is entered. 
After the interactive session completes, the session will return to the previous node.
