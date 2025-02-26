# Custom module Files

ICDS uses the [Lmod Environment Module System](https://lmod.readthedocs.io/en/latest/). 
This system is highly exandable and allows for the creation and use of custom module files.

## Module File Structure

Common components of a modulefile are:

- **whatis():** Supplies information for `module info` and `module spider` output
- **load():** Loads other modules when this module is loaded
- **prepend_path():** Modifies environmental variables in the user's environment. Common ones 
include `PATH`, `LD_LIBRARY_PATH`, and `CPATH`.

### Example Module File

Here is the contents of the `gromacs/2024.3` module file:

```
whatis([[Name : gromacs]])
whatis([[Version : 2024.3]])
whatis([[Target : haswell]])

whatis([[Description : GROMACS is a versatile molecular dynamics package.]])
whatis('URL: https://www.gromacs.org')

whatis([[Configure options: -DGMX_MPI=off 
-DCMAKE_INSTALL_PREFIX=/storage/icds/RISE/sw8/gromacs/gromacs-2024.3/install 
-DGMX_DOUBLE=off -DGMX_BUILD_OWN_FFTW=ON -DGMX_GPU=off]])

help([[This GROMACS version was built on 10/22/2024 on p-sc-2370, using the gcc
v13.2.0 compilers with openmpi v5.0.3 and cuda toolkit v12.6.2.]])

-- Local variables
local base = '/storage/icds/RISE/sw8/gromacs/gromacs-2024.3/install'

-- Additional modules
load('gcc/13.2.0')
load('cuda/12.6.2')
load('openmpi/5.0.3')

-- Take care of $PATH, $LD_LIBRARY_PATH, $MANPATH etc
prepend_path('PATH', pathJoin(base,'bin'))
prepend_path('MANPATH', pathJoin(base,'share/man'))
prepend_path('LD_LIBRARY_PATH', pathJoin(base,'lib64'))
prepend_path('LIBRARY_PATH', pathJoin(base,'lib64'))
prepend_path('C_INCLUDE_PATH', pathJoin(base,'include'))
prepend_path('CPLUS_INCLUDE_PATH', pathJoin(base,'include'))
prepend_path('CPATH', pathJoin(base,'include'))
prepend_path('PKG_CONFIG_PATH', pathJoin(base,'lib64/pkgconfig'))
```

## Loading Custom modules

The `module use` command is used to specify the location of module files:

```
module use <module_directory>
```

in which `<module_directory>` is the path to your modules.

Adding the `module use` line to your `.bashrc` file will make the modules automatically accessable 
upon login.

Creating module files within group storage directories can make them accessable to all group members. 
Ensure that the correct [file permissions](../../handling-data/managing-files/file-permissions.md) are set 
to allow all group members to read and execute the module files.
