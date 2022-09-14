---
title: Software on Roar
---

#### 99.1 Roar Software Stack

Many common research software packages are already installed and available for Roar users. Most of this software is installed on the Roar software stack as software modules which can be loaded and unloaded with relative ease. Be sure to reserve compute nodes and/or processors to run research sofware because running computationally expensive software on submit nodes will drastically reduce computing performance.


#### 99.2 Using Software Modules

All modules, available versions, and defualt versions on the software stack are viewed and loaded with the following commands:

```
$ module avail
$ module load <module_name>
```

Some research software has multiple versions available to users. If no version is specified, then the default version will be loaded. To load the default version module of a module, in this case Matlab, no version number is necessary. A specific software version can be specified by including the version number while loading the module. Version specification is only pertinent if multiple versions of a specific software module are available. The software stack is periodically updated, so specifying a version number will ensure reproducibility across these software updates.  

```
$ module load matlab
$ module load matlab/R2020a
```

Some modules shown may contain submodules that will be shown as available if the parent module is loaded. For example, the default GCC module is gcc/8.3.1 and contains numerous submodules. The submodules are available to be loaded once the parent module is loaded.

```
$ module load gcc
$ module avail
```


#### 99.3 Extended Software Stack

If a software package or a specific version is not available on the main software stack, it may be available in the RISE software stack which is also accessible to Roar users. After specifying this alternate software location, the modules in the RISE software stack are accessible just like any module on the main software stack.

```
$ module use /gpfs/group/RISE/sw7/modules
$ module avail
```

