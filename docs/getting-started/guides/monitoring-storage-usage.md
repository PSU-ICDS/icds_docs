# How To: Monitor and Manage Your Storage Usage

Use this guide to check how much storage you are using across Roar's filesystems, identify what is consuming space, and keep usage under your quotas before problems arise.

Catching quota issues early prevents the errors described in [Quota issues in $HOME](quota-issues-in-home.md) and avoids disruption to running jobs.

---

## Step 1: Check your quota on each filesystem

Run `quota -s` to see your current usage and limits across all your storage allocations:

```bash
quota -s
```

The output shows space used versus your limit for each filesystem. If used space is at or near the limit, take action before it fills completely.

Roar's main storage locations and their typical purposes:

| Location | Variable | Use for |
| ---- | ---- | ---- |
| `/storage/home/$USER` | `$HOME` | Config files, scripts, small inputs |
| `/storage/work/$USER` | `$WORK` | Large datasets, conda environments, outputs |
| `/scratch/$USER` | `$SCRATCH` | Temporary job I/O (deleted after 30 days) |
| `/storage/group/...` | — | Shared group storage |

---

## Step 2: Find what is using space

### In $HOME

Show the size of each top-level item in your home directory, including hidden dotfiles, sorted from smallest to largest:

```bash
du -xh --max-depth=1 "$HOME"/.[!.]* "$HOME"/* 2>/dev/null | sort -h
```

Drill into a specific directory:

```bash
du -xh --max-depth=1 "$HOME/.local" | sort -h
```

Find the 20 largest individual files:

```bash
find "$HOME" -type f -printf '%s\t%p\n' 2>/dev/null | sort -nr | head -20 | awk '{ printf "%.1f MB\t%s\n", $1/1024/1024, $2 }'
```

### In $WORK

```bash
du -xh --max-depth=1 "$WORK" | sort -h
```

---

## Step 3: Identify and clean common space consumers

### Package and software caches

These caches are safe to clear — they are recreated automatically on next use:

```bash
# pip download cache
pip cache purge

# conda package cache and unused environments
conda clean --all -y

# Apptainer image cache
apptainer cache clean
```

### Stale job output files

Review and remove output files from completed jobs you no longer need:

```bash
ls -lh slurm-*.out
```

### Scratch files

`$SCRATCH` is automatically purged after 30 days, but you can remove files manually to free space immediately:

```bash
du -xh --max-depth=1 "$SCRATCH" | sort -h
```

---

## Step 4: Move large directories out of $HOME

`$HOME` has the smallest quota. Large directories — such as `.conda`, `.local`, and `.cache` — should live in `$WORK`.

Move a directory and replace it with a symlink so applications continue to find it:

```bash
# Example: move .conda to $WORK
rsync -a "$HOME/.conda/" "$WORK/.conda/"
rm -rf "$HOME/.conda"
ln -s "$WORK/.conda" "$HOME/.conda"

# Verify
ls -ld "$HOME/.conda"   # should show -> $WORK/.conda
```

Repeat for other large directories such as `.local` or `.cache`.

!!! note "Do not move shell config files"
    Never move `.ssh`, `.bashrc`, `.profile`, or other shell startup files. Only move application data directories.

---

## Step 5: Re-check your quota

After cleaning up, verify that usage has dropped:

```bash
quota -s
```

---

## Tips

- Check your quota regularly, not only when errors occur.
- Direct job output files to `$WORK` or `$SCRATCH` instead of `$HOME`:

  ```bash
  #SBATCH --output=$WORK/logs/job_%j.out
  #SBATCH --error=$WORK/logs/job_%j.err
  ```

- Do not use `$SCRATCH` for files you need to keep. It is not backed up and files are deleted after 30 days.

## Additional resources

- [File storage](../../file-system/file-storage.md)
- [Quota issues in $HOME](quota-issues-in-home.md)
- [Managing files](../../file-system/managing-files.md)
- [Contact ICDS support](../getting-help.md)
