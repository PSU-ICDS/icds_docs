## Job Composer

**Job Composer** is a web-based tool available through the [Roar Collab Portal](https://portal.hpc.psu.edu) that simplifies creating, managing, and submitting batch jobs — **no command line required**.

It is part of **Open OnDemand**, a user-friendly interface for HPC systems, and is built using the **Ruby on Rails** web framework.


### Why use Job Composer?

Many users follow a common workflow:
1. Copy a previous job directory (their own or a colleague’s)
2. Edit a few input files
3. Submit the new job

**Job Composer automates and streamlines this process** using **templates**.


### How It Works

- **Templates** are pre-configured directories containing:
  - Job scripts (`.sh`, `.slurm`)
  - Input files (`.inp`, `.cfg`, etc.)
  - Example data
- You **start from a template** (or a past job), modify what you need, and submit — all via a web form.
- No need to manually copy files or edit scripts on the command line.



### Getting Started

1. Log in to the [Roar Collab Portal](https://portal.hpc.psu.edu)
2. Navigate to **Interactive Apps > Job Composer**
3. Choose:
   - **New Job from Template** (start fresh)
   - **New Job from Existing Job** (copy a previous run)
4. Edit files in the browser
5. Click **Submit**

> **Tip**: Ask your group to share useful templates — they appear under “Shared Templates” if permissions allow.


### Best Practices

- Use **descriptive job names**: `Rstudio-analysis-run2`, not `job1`
- Save successful jobs as **personal templates** for reuse
- Clean up old jobs regularly (use **Delete** in Job Composer)

