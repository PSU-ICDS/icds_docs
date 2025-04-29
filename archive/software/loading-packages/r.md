# Managing R Libraries

R is a free software environment for statistical computing and graphics. 
Many commonly used libraries have been preloaded on Roar Collab and can be 
used with the `library()` command.

## R Versions

R users should make sure that the version of R remains consistent. 
Several R versions are available, and when a package is installed in one version, it is not always accessible when operating in another version. 
Always check the R version and remain consistent! 

## Installing R Packages

R packages can be installed from within the R console with the following command:

```
> install.packages( <package> )
```

The first time you run this command in a single version of R, you will be prompted to create a personal library.
The default location for your personal library is the `.R` directory found in your home directory. 

After installation, packages can then be loaded using the following command in the R console:

```
> library( <package> )
```

### Custom library paths

To install a package in a custom location, an install location can be specified using the `lib` argument:

```
> install.packages( "<package>", lib="<install_path>" )
```

To load a package installed in a non-standard location, the `lic.loc` argument of the `library()` command is used to specific the install location:

```
> library( <package>, lib.loc="<install_path>" )
```

Another method to specify package installation locations for R is to modify the `R_LIBS` or `R_LIBS_USER` 
environment variable before launching an R console session. `R_LIBS` is sufficent for command line use of R, 
but if RStudio is being used, the `R_LIBS_USER` environment variable must be modified before launching RStudio. 

Modifying these environment variables properly can eliminate the need to use the `lib.loc` option of R's `library()` command.

It is recommended to review dependencies of any packages to be installed because additional software may have to 
be loaded in the environment before launching the R console. 

For example, some R packages utilize CMake to perform the installation. 
In that case, the *cmake* module should be loaded before launching the R console session.


### Dependencies

Some R packages may require additional software or changes to the user environment before the package 
can be installed successfully within the R console. Sometimes this is loading a necessary compiler version 
or other software dependencies which is accomplished by using the `module load` command prior to launching 
R session.

Always check the package documentation for details on which dependencies a specific package requires. CRAN hosted packages 
almost always have a Reference manual which specify dependencies.

### R Package Installation Example: units


Sometimes dependent software or libraries will need to be downloaded and installed to proceed with the R package
installation.

For example, to install the R package `units`, we can see by [the package documentation](https://cran.r-project.org/web/packages/units/units.pdf) 
that it requires the C library udunits-2 as specified under "SystemRequirements". Before we can install `units` 
the system library udunits-2 must be downloaded and compiled:
 
```
$ wget https://downloads.unidata.ucar.edu/udunits/2.2.28/udunits-2.2.28.tar.gz
$ tar -xvf udunits-2.2.28.tar.gz
$ cd udunits-2.2.28
$ ./configure prefix=$HOME/.local
$ make
$ make install
```

Once the library is compiled, certain environmental variables are updated to ensure R can find the 
udunits-2 library:

```
$ export UDUNITS2_INCLUDE=$HOME/.local/include
$ export UDUNITS2_LIBS=$HOME/.local/lib
$ export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
```

Now that the requirements are set up and available, we can proceed with installing the R package:
```
$ module load r/4.2.1
$ R
> install.packages("units")
> library(units)
```

