# HPC Storage Quota How‑To (CLI & Open OnDemand)

A practical, step‑by‑step guide to help users find and fix “quota exceeded” problems in **$HOME**, move bulky data to **$WORK** or **$GROUP**, and safely reclaim space.

> Caution: Before deleting anything, skim contents and confirm it’s not active project data or job outputs. Stop Interactive Apps that may be using those files.

> Who is this for? HPC users comfortable with either the Linux command line or the Open OnDemand (OOD) web portal. Steps are provided for both paths.

---

## Quick checklist

- Reveal hidden “dot” files and folders (e.g., `.local`, `.conda`, `.comsol`). These are common culprits.
- Measure usage by directory (including hidden items) with `du`.
- Clean unneeded caches/session data (e.g., **pip** cache; R/COMSOL session folders).
- Move large application data (e.g., `.local`, `.comsol`, conda/pip/env caches) from **$HOME** to **$WORK** or **$GROUP**, then create a **symlink** back into **$HOME**.
- Verify freed space and quotas.

---

## 1) Hidden directories in $HOME (what they are & how to see them)

**What are dotfiles?** On Linux/Unix systems, files and folders whose names start with a dot (e.g., `.local`, `.conda`) are hidden by default. Many tools store **config, cache, and session** data here—useful, but they can quietly grow large. Common examples in HPC homes include `.conda`, `.comsol`, and `.local`.

### See hidden items — Linux command line

- List everything (including hidden):

```Shell
ls -A ~
```

- Show sizes for top‑level items in `$HOME`, including hidden:

```Shell
du -xh --max-depth=1 "$HOME"/.[!.]* "$HOME"/* 2>/dev/null | sort -h
```

*Tip:* add `-S` to `sort` for biggest at the bottom.

### See hidden items — Open OnDemand (web file manager)

- Open **Files** in OOD → use the settings/gear menu and enable **Show Dotfiles** to reveal `.`‑prefixed items.
- If using **Globus** for transfers, enable **Show Hidden Files** in its file browser to see dotfiles.

---

## 2) Identify large files and directories with du (including hidden)

### Linux command line

- **Top‑level usage in $HOME** (human‑readable sizes):

```Shell
du -xh --max-depth=1 "$HOME"/.[!.]* "$HOME"/* 2>/dev/null | sort -h
```

- **Drill down** into a specific directory (example: `.local`):

```Shell
du -xh --max-depth=1 "$HOME/.local" | sort -h
```

- **Find the biggest regular files** under `$HOME` (top 20):

```Shell
find "$HOME" -type f -printf '%s\t%p\n' 2>/dev/null | sort -nr | head -20 | awk '{ printf "%.1f MB\t%s\n", $1/1024/1024, $2 }'
```

### Open OnDemand

- **Files app** → navigate into directories; enable **Show Dotfiles**; use the size column or download to inspect.
- For precise measurement, open a shell via **Clusters → Shell Access** (or an Interactive App terminal) and run the `du` commands above.

---

## 3) Fix common problems

### A. Delete unnecessary session/config data (R and COMSOL examples)

> Goal: Remove stale sessions and logs that are safe to regenerate.

#### Linux command line

1. **Inspect R/IDE session data** (often under `.local/share`):

```Shell
du -xh --max-depth=2 "$HOME/.local/share" | sort -h
```

If you identify clearly stale session folders (e.g., past RStudio sessions), remove them:

```Shell
rm -rf "$HOME/.local/share/rstudio/sessions"/*
```

*(Adjust paths to match what you see.)*

1. **Inspect COMSOL data** (typically under `.comsol`):

```Shell
du -xh --max-depth=2 "$HOME/.comsol" | sort -h
```

Remove unneeded logs/temporary data (confirm before deleting):

```Shell
rm -rf "$HOME/.comsol"/temp "$HOME/.comsol"/logs 2>/dev/null || true
```

#### Open OnDemand

- **Files** → enable **Show Dotfiles** → navigate to `.local/share` and `.comsol` → delete clearly unneeded `sessions`, `temp`, or `logs` subfolders.
- If deletion is blocked because files are in use, stop the related Interactive App (e.g., RStudio Server, COMSOL) and retry.

---

### B. Clear the pip cache

The pip download cache (usually `~/.cache/pip`) can grow large without affecting installed packages.

- **Check size**:

```Shell
du -sh "$HOME/.cache/pip"
```

- **Purge safely** (works with the currently loaded Python):

```Shell
python -m pip cache purge
# or
pip cache purge
```

This removes cached wheels/tarballs and may immediately free space.

> Optional (Conda users): `conda clean --all -y` can also free space from Conda caches and unused packages. (Review what will be removed before running.)

---

### C. Move large directories to $WORK or $GROUP and create a symlink

> Why: $HOME is usually quota‑limited; $WORK/$GROUP are for larger, high‑throughput data. Move bulky app data there, then keep tools happy by symlinking back to $HOME.

#### Safer copy‑then‑link approach (recommended)

1. **Pick a target** (e.g., move `.local`):

```Shell
echo "WORK=$WORK"; echo "GROUP=$GROUP"  # verify these exist
mkdir -p "$WORK/.local"
rsync -a "$HOME/.local/" "$WORK/.local/"
```

1. **Replace original with a symlink**:

```Shell
rm -rf "$HOME/.local"
ln -s "$WORK/.local" "$HOME/.local"
ls -ld "$HOME/.local"  # should show -> $WORK/.local
```

1. **Test your applications**, then remove any temporary backups you kept.

#### Minimal example (as shown in your current doc)

```Shell
# Move and link .local
mv ~/.local "$WORK/.local"
ln -s "$WORK/.local" ~/.local
```

This is the same pattern you documented for relocating `.local` from `$HOME` to `$WORK` with a symlink pointing back.

> You can use the same approach for other large directories (e.g., .comsol, .conda, .cache, custom toolkits). Do not move critical login/startup files like .ssh, .bashrc, .profile.

#### Open OnDemand

- Use **Clusters → Shell Access** to run the commands above. (Most OOD file managers can’t create symlinks reliably across filesystems.)

---

## 4) Verify you freed space

### Linux command line

- Re‑run the size checks:

```Shell
du -xh --max-depth=1 "$HOME"/.[!.]* "$HOME"/* 2>/dev/null | sort -h
```

- If your site supports it, check filesystem quotas (examples):

```Shell
quota -s     # or: lfs quota -u "$USER" /path/to/fs  (Lustre sites)
```

### Open OnDemand

- Refresh the **Files** view and re‑check sizes. If your portal shows quota widgets, verify usage there.

---

## 5) Safety notes & best practices

- **Stop interactive sessions** (e.g., Jupyter, RStudio, COMSOL) before moving/deleting their data.
- Prefer **rsync copy → replace → symlink** over a direct `mv` when moving between filesystems.
- Exclude **project data** from `$HOME`. Keep `$HOME` for configs; keep **datasets, outputs, and scratch** in `$WORK`/$GROUP`.
- Consider periodic housekeeping:
    - `python -m pip cache purge` (and `conda clean --all`) after big install cycles.
    - Delete old job logs, temporary checkpoints, and stale virtual environments.

---

## 6) Common one‑liners (copy/paste)

```Shell
# Show biggest top-level items in $HOME (includes hidden)
du -xh --max-depth=1 "$HOME"/.[!.]* "$HOME"/* 2>/dev/null | sort -h

# Check pip cache usage and purge it
du -sh "$HOME/.cache/pip"; python -m pip cache purge

# Move .local to $WORK and link it back (safer copy-first)
mkdir -p "$WORK/.local" && rsync -a "$HOME/.local/" "$WORK/.local/" \
  && rm -rf "$HOME/.local" && ln -s "$WORK/.local" "$HOME/.local"
```

---

## 7) Troubleshooting

- **“Permission denied” deleting files**: Are they owned by you? Try `ls -l`. Stop apps that may hold open files.
- **App can’t find its config after move**: Confirm the symlink path and spelling; some apps require the exact home‑relative path.
- **No $WORK/$GROUP set**: Check your site’s docs or ask support to confirm the correct paths.
