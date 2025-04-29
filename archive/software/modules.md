# Software modules

To manage multiple software packages, including different versions of the same software, 
ICDS uses the [Lmod Environment Module System](https://lmod.readthedocs.io/en/latest/) to 
prevent conflicts and compartmentalize software and compiler usage.

Users can use the `module` command combined with different subcommands to access and use 
pre-installed software.

## List of Common module commands

| Command | Description |
| ---- | ---- |
| `module avail` | List all modules |
| `module show <module_name>` | Show module file contents |
| `module spider <module_name>` | Search for a module |
| `module load <module_name>` | Load a module |
| `module load <module>/<version>` | Load a specific version |
| `module unload <module_name>` | Unload a module |
| `module list` | List all loaded modules |
| `module purge` | Unload all modules |
| `module use <path>` | Add a path to `$MODULEPATH` |


!!! tip ""
     Batch files must include `module load` commands to load the modules they need.
     Modules you have loaded when you submit a job with `sbatch` are not inherited by the job.

!!! tip ""
     `module show <module_name>` provides detailed information on what changes are made to the 
     user environment when a module is loaded, including changes to environmental variables such as 
     $PATH and $LD_LIBRARY_PATH.
