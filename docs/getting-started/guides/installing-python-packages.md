# How To: Install a Python Package Not Available as a Module

Use this guide when you need a Python package that is not available through the module system. There are two main approaches: installing with `pip --user` for simple cases, and creating a conda environment for more complex or isolated needs.

---

## Before you start: open an interactive session

Do not install packages on a submit node. Processes on submit nodes that consume significant resources are killed. Start an interactive session on a compute node first:

```bash
salloc --nodes=1 --ntasks=2 --mem=8G --partition=standard --account=<account> --time=01:00:00
```

Or use a **Persistent Terminal** or **Interactive Desktop** session on the [Portal](https://portal.hpc.psu.edu).

---

## Option A: Install with pip (simple packages)

Use this approach for packages with no complex dependencies.

### Step 1: Load a Python module

```bash
module load python/3.11.2
```

### Step 2: Install the package to your user directory

The `--user` flag installs the package under `$HOME/.local`, which is automatically on your Python path:

```bash
pip install --user <package-name>
```

### Step 3: Verify the installation

```bash
python3 -c "import <package-name>; print('OK')"
```

### Step 4: Use the package in a batch job

In your batch script, load the same Python module version you used for installation:

```bash
module purge
module load python/3.11.2
python3 myscript.py
```

!!! note "Match module versions"
    Packages installed with `pip --user` under `python/3.11.2` are not available under `python/3.9.7`. Always load the same version you used for installation.

---

## Option B: Create a conda environment (isolated environments)

Use this approach when you need specific package versions, complex dependencies, or isolated environments for different projects. Conda environments are stored in `$WORK` by default, keeping them out of your home directory quota.

### Step 1: Load the Anaconda module

```bash
module load anaconda
```

If you see a `(base)` prompt, deactivate it first:

```bash
conda deactivate
```

### Step 2: Create a new environment

Create the environment in your `$WORK` directory to avoid filling `$HOME`:

```bash
conda create -p $WORK/.conda/envs/myenv python=3.11
```

### Step 3: Activate the environment

```bash
conda activate $WORK/.conda/envs/myenv
```

### Step 4: Install packages

```bash
conda install <package-name>
```

For packages not in conda channels, use pip within the activated environment:

```bash
pip install <package-name>
```

### Step 5: Use the environment in a batch job

```bash
module load anaconda
conda activate $WORK/.conda/envs/myenv

python3 myscript.py
```

---

## Troubleshooting

### "pip --user" fills up $HOME

The `.local` directory under `$HOME` can grow large. Move it to `$WORK` and leave a symlink:

```bash
rsync -a $HOME/.local/ $WORK/.local/
rm -rf $HOME/.local
ln -s $WORK/.local $HOME/.local
```

See [Quota issues in $HOME](quota-issues-in-home.md) for more detail.

### A package requires a system library

Some packages (e.g., those that compile C extensions) need system libraries. Load the relevant module before installing:

```bash
module load hdf5/1.12.2
pip install --user h5py
```

Check the package documentation for required system dependencies.

---

## Additional resources

- [Python packages](../../packages/python.md)
- [Anaconda](../../packages/anaconda.md)
- [Quota issues in $HOME](quota-issues-in-home.md)
- [Contact ICDS support](../getting-help.md)
