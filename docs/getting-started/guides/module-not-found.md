# How To: Fix "Module Not Found" or "Command Not Found" Errors

Use this guide when a `module load` command fails, when software you expect to be available is not found, or when commands that worked in one session do not work in another.

---

## Step 1: Search for the module by name

If `module load <name>` fails, the module name or version may differ from what you expect. Search all available modules — including those that are not currently visible — with `module spider`:

```bash
module spider <name>
```

For example:

```bash
module spider python
```

This returns all versions and any prerequisite modules that must be loaded first.

---

## Step 2: Load any required prerequisites

Some modules are only accessible after loading a prerequisite (often a compiler or MPI library). `module spider` will tell you:

```
You will need to load all module(s) on any one of the lines below before the "python/3.11.2" module is available to load.

  gcc/11.3.1
```

Load the prerequisite first, then load the software:

```bash
module load gcc/11.3.1
module load python/3.11.2
```

---

## Step 3: Check for conflicting modules

Modules can conflict with each other. If you get an error like `cannot be loaded due to a conflict`, first unload conflicting modules or start fresh:

```bash
module purge
module load <name>
```

To see what is currently loaded:

```bash
module list
```

---

## Step 4: Specify a version explicitly

If the default version of a module does not work as expected, or if you need a specific version, load it explicitly:

```bash
module load python/3.9.7
```

`module spider <name>` lists all available versions.

---

## Step 5: Check the Portal software list

You can browse all available software on Roar from the Portal without being on the command line:

1. Log in to the [Portal](https://portal.hpc.psu.edu).
2. In the top menu, go to **Clusters → Available Modules**.
3. Search for the software by name.

---

## Step 6: If the software is not available as a module

If `module spider` returns no results for the software you need, you have a few options:

- **Use a container**: Apptainer can run Docker images and pre-built container images, giving you access to software not installed on Roar. See [Using containers](../../software/containers.md).
- **Install from source**: For libraries and tools that can be compiled, see [Installing from source](../../software/installing-from-source.md).
- **Install a Python package**: If you need a Python package, see [How to install a Python package](installing-python-packages.md).
- **Request the software**: Contact [ICDS support](../getting-help.md) to request that new software be added to the module system.

---

## Tips

- Avoid loading modules in `~/.bashrc`. This can cause conflicts and may prevent login. Load modules at the top of each batch script instead.
- In batch scripts, start with `module purge` to ensure a clean environment before loading what you need.
- Specify full module versions in scripts (`python/3.11.2`, not just `python`) so results are reproducible.

## Additional resources

- [Using modules](../../software/modules.md)
- [Using containers](../../software/containers.md)
- [Contact ICDS support](../getting-help.md)
