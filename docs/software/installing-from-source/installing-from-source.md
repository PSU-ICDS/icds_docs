# Compiling From Source

Compiling software from source is the most involved option for using software, but it gives the user the highest level of control. 
Research computing software is often developed by academic researchers that do not place a large effort on packaging their software so that it can be easily deployed on other systems. 
If the developer does not package the software using a package manager, then the only option is to build the software from source. 
It is best to follow the installation instructions from the developer to successfully install the software from source.

It is recommended to build software on a node with the same processor type that will be used for running the software. 
On a compute node, running the following command displays the processor type:

```
$ cat /sys/devices/cpu/caps/pmu_name
```

Software builds are not typically back-compatible and will not run successfully on processors older than the processor used to build. 
It is recommended to build on haswell (the oldest processor architecture on Roar) if you wish to have full compatibility across any Roar compute node. 
To optimize for performance, however, build on the same processor on which the software runs.

    | Release Date | Processor |
    | :----: | :----: |
    | 2013 | haswell |
    | 2014 | broadwell |
    | 2015 | skylake |
    | 2019 | cascadelake |
    | 2019 | icelake |
    | 2023 | sapphirerapids |


## wget

The first step is to get the source package (typically a tarball of some sort)
from the developer website onto Collab.
If you are logged on with Interactive Desktop or an SSH -X session, 
you can launch Firefox and download software using the browser.

Alternatively, you can use [`wget`][wget],
to download source packages from the web:
[wget]: https://linux.die.net/man/1/wget
```
wget <webAddress>
```
where `<webAddress>` can be copied from a browser link pointing to the file.
Then, **read the README files**, and see what you are up against.

## cmake

Many source packages are built using [`cmake`][cmake],
a Unix tool for controlling the compile and load process.
To use cmake, first load its module:
[cmake]: https://cmake.org/cmake/help/latest/manual/cmake.1.html

```
module load cmake
```

To build from source, the typical procedure
is to `cd` into the source folder,
and execute in turn:

```
mkdir build
cd build
cmake <options>
make
make install
```

Here `<options>` is a list of options for cmake,
that may control what version of the software to build,
what assumptions to make about the CPU,
what packages to include,
and where to install the resulting executables.
Well-designed source packages include help files
that describe the various build options.
