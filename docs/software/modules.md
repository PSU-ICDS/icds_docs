# Using modules

The Roar software environment is split into two parts: **preloaded
software** (available immediately upon login) and **modular software**
(which must be explicitly loaded).

To manage conflicts that arise from different applications requiring
different versions of libraries, Roar uses the [Lmod Environment Module
System](https://lmod.readthedocs.io/en/latest/).

## Finding software

To check if software is currently loaded, use `which`. <br>
`which <appName>` looks for the application `appName` on your `$PATH`,
and returns the full path to the executable.

### Search available modules

If `which` doesn't find the application, use `module spider` to search
all available modules.

``` bash
module spider <moduleName>
```

### Software list on Portal

From the [Portal](../running-jobs/portal.md), a searchable list 
of software is provided in the top menu, at  "Clusters / Available Modules". 

## Module commands

Commonly used module commands include:

| Command | Action |
|----------|---------|
| `module avail` | Lists all modules available to your current environment. | 
| `module spider <name>` | Searches for *all* modules, even those currently hidden. | 
| `module load <name>` | Loads the default version of the module. | 
| `module load <name>/<version>` | Loads a specific version of the software. | 
| `module unload <name>` | Removes the software and its environment settings. | 
| `module list` | Shows all modules currently loaded. | 
| `module purge` | Unloads all currently loaded modules. | 
| `module show <name>` | Displays module environment variables, paths, and settings. | 


### Default versions

`module avail <name>` or `module spider <name>` typically indicates
the default version with a marker (`(D)`, `(default)`, or `*`).

Running `module load` without specifing a version loads the default.
To load a different version, specify the complete module name,
as in `module load python/3.9.7`.

### Changing default software stack

In January 2026, ICDS implemented a new software stack based on the Spack package manager. 
This may cause problems for software installed under the old system. <br>
To force usage of the old stack, unload the new stack:

```
module unuse /storage/icds/sw8/modulefiles/Core
```

## Tips for batch scripts

Follow these best practices to avoid conflicts between modules and ensure reliable execution:

- Use `module purge` first. 
- Load only what is necessary. 
- Specify full module versions.

!!! warning "Be careful when loading modules in `.bashrc`"
	Loading modules in your `~/.bashrc` can cause software conflicts, 
	and even prevent login.
