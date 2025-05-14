# R Libraries

R is a free software environment for statistical computing and graphics. 
Many commonly used libraries have been preloaded on Roar and can be 
used with the `library()` command.

!!!warning "Always check your R version."
	A package installed in one version of R
	may not be accessible in another version. 

## Installing R packages

R packages can be installed from the R console:

```
> install.packages( <package> )
```

The first time you run this command in a given version of R, 
you will be prompted to create a personal library;
The default location is the `.R` directory in your home directory. 

After installation, packages can then be loaded with:

```
> library( <package> )
```

## Custom library paths

To install a package in a custom location, specify a path:

```
> install.packages( "<package>", lib="<install_path>" )
```

To load a package installed in a non-standard location, 
specify the location with `lic.loc`:

```
> library( <package>, lib.loc="<install_path>" )
```

Alternatively, before launching an R session,
modify the `R_LIBS` or `R_LIBS_USER` environment variable,
which tells R where to look for libraries. 
For command-line use of R, changing `R_LIBS` suffices;
for RStudio, `R_LIBS_USER` must also be modified. 

## Dependencies


Some R packages require additional software or changes to the user environment, 
before the package can be installed. 

For example, some R packages use CMake to perform installations;
others may require a particular version of a compiler to be loaded.
Be sure to use `module load` to load the necessary dependencies 
before launching R.

!!!warning "Always check R package documentation for required dependencies." 
	CRAN hosted packages almost always have a Reference manual which specify dependencies.

## Example: units


For example, to install the R package `units`, 
the [package documentation](https://cran.r-project.org/web/packages/units/units.pdf) 
lists the C library udunits-2 under "SystemRequirements". 
So we must download and compile udunits-2:
 
```
$ wget https://downloads.unidata.ucar.edu/udunits/2.2.28/udunits-2.2.28.tar.gz
$ tar -xvf udunits-2.2.28.tar.gz
$ cd udunits-2.2.28
$ ./configure prefix=$HOME/.local
$ make
$ make install
```

Next, we set environmental variables so R can find the udunits-2 library:

```
$ export UDUNITS2_INCLUDE=$HOME/.local/include
$ export UDUNITS2_LIBS=$HOME/.local/lib
$ export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
```

Now we can install the `units` package:
```
$ module load r/4.2.1
$ R
> install.packages("units")
> library(units)
```

