# Python

Several common software platforms, 
including Python (a widely used programming language), 
are highly extensible by loading packages.

Packages can be loaded within the application,
or before the application is launched by using a package manager.

`pip` is the package installer for Python.
To load Python packages on Roar, use `pip` with the option `--user`
(which directs Python to install the package for a single user):

```
pip install --user <package>
```

Sometimes, Python package libraries can become too large to store in the home directory.   
To remedy this, see [Quota issues in home](../file-system/file-storage.md/#quota-issues-in-home).

Python installations can be managed by [Anaconda](./anaconda.md/#anaconda).
