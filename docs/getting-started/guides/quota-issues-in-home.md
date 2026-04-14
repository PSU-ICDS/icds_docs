# How To: Fix Storage Quota Issues in $HOME

Use this guide when you see "Permission Denied" or "Quota exceeded" errors caused by your home directory being over its storage limit. The most common culprits are hidden directories (dotfiles) and package caches.

!!! warning "Before deleting anything"
    Skim directory contents to confirm they are not active project data or job outputs. Stop any Interactive Apps (Jupyter, RStudio, COMSOL) that may be using files you plan to move or delete.

---

## Step 1: Reveal hidden files and measure usage

Hidden files (dotfiles) start with a `.` and are not shown by default. They are often the source of unexpected disk usage.

### Command line

Show sizes for all top-level items in `$HOME`, including hidden ones, sorted by size:

```bash
du -xh --max-depth=1 "$HOME"/.[!.]* "$HOME"/* 2>/dev/null | sort -h
```

To drill down into a specific directory (e.g., `.local`):

```bash
du -xh --max-depth=1 "$HOME/.local" | sort -h
```

To find the 20 largest individual files anywhere under `$HOME`:

```bash
find "$HOME" -type f -printf '%s\t%p\n' 2>/dev/null | sort -nr | head -20 | awk '{ printf "%.1f MB\t%s\n", $1/1024/1024, $2 }'
```

### Open OnDemand portal

In the **Files** section, check the box for **Show Dotfiles** to reveal hidden items. For precise measurements, open a terminal via **Clusters → Shell Access** and run the `du` commands above.

### Globus

In the file browser settings, select **Show Hidden Files**.

Common large hidden directories include:

- `.conda` — used by Anaconda
- `.comsol` — used by COMSOL
- `.local` — used by many applications (including RStudio)
- `.cache/pip` — Python pip download cache

---

## Step 2: Delete stale session and cache data

Some applications leave behind session files, logs, and temporary data that are safe to remove.

### R / RStudio session data

Inspect session data stored under `.local/share`:

```bash
du -xh --max-depth=2 "$HOME/.local/share" | sort -h
```

If you find stale RStudio sessions, remove them:

```bash
rm -rf "$HOME/.local/share/rstudio/sessions"/*
```

### COMSOL temporary data

Inspect COMSOL data:

```bash
du -xh --max-depth=2 "$HOME/.comsol" | sort -h
```

Remove unneeded logs and temporary files:

```bash
rm -rf "$HOME/.comsol"/temp "$HOME/.comsol"/logs 2>/dev/null || true
```

You can also do this through the **Files** app in Open OnDemand: enable **Show Dotfiles**, navigate to `.local/share` or `.comsol`, and delete unneeded subfolders. If deletion is blocked, stop the related Interactive App first and retry.

---

## Step 3: Clear package caches

### pip cache

The pip download cache stores wheels and tarballs that are not needed after installation. It is safe to clear.

Check its size:

```bash
du -sh "$HOME/.cache/pip"
```

Clear it:

```bash
pip cache purge
```

### Conda cache

If you use Conda, you can also free space from cached packages and unused environments:

```bash
conda clean --all -y
```

Review the output before confirming if you want to be selective.

---

## Step 4: Move large directories to $WORK and create a symlink

If a dotfile directory is still too large after clearing caches, move it to `$WORK` and leave a symbolic link in its place so applications continue to work normally.

**Recommended approach — copy first, then replace:**

```bash
# 1. Copy to $WORK (preserves permissions and symlinks)
mkdir -p "$WORK/.local"
rsync -a "$HOME/.local/" "$WORK/.local/"

# 2. Replace the original with a symlink
rm -rf "$HOME/.local"
ln -s "$WORK/.local" "$HOME/.local"

# 3. Verify the symlink is correct
ls -ld "$HOME/.local"   # should show -> $WORK/.local
```

Test your applications after relinking, then remove any temporary backups you kept.

Use the same pattern for other large directories such as `.conda`, `.comsol`, or `.cache`.

!!! note "Do not move critical login files"
    Never move `.ssh`, `.bashrc`, `.profile`, or other shell startup files. Only move application data directories.

---

## Step 5: Verify your quota

Re-run the size check to confirm space has been freed:

```bash
du -xh --max-depth=1 "$HOME"/.[!.]* "$HOME"/* 2>/dev/null | sort -h
```

Check your filesystem quota directly:

```bash
quota -s
```

If you are still over quota after following all steps above, [contact ICDS support](../getting-help.md).
