# How To: Run a GPU Job

Use this guide to submit a batch job or start an interactive session that uses a GPU on Roar.

---

## Step 1: Confirm your application uses GPUs

Requesting a GPU for software that does not use one wastes credits without speeding up your work.

Check your software's documentation to confirm GPU support. Common GPU-accelerated tools include CUDA applications, TensorFlow, PyTorch, and MATLAB with the Parallel Computing Toolbox.

---

## Step 2: Choose a GPU type

Roar has several GPU types at different cost and performance levels:

| GPU | Performance | Relative cost |
| ---- | ---- | ---- |
| A100 | High | Highest |
| A40 | High | High |
| V100 | Mid | Moderate |
| P100 | Mid | Lower |

Request the least powerful GPU that meets your needs to conserve credits. Use `sinfo` to see current availability:

```bash
sinfo --Format=features:30,nodelist:20,gres:30 | grep gpu
```

See [Compute hardware](../../system/compute-hardware.md) and [System Overview](../../system/system-overview.md) for full details on GPU nodes.

---

## Step 3: Write your batch script with a GPU request

Add a `--gres` directive to request the GPU type and count:

```bash
#!/bin/bash
#SBATCH --account=account_id
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem=16G
#SBATCH --gres=gpu:p100:1
#SBATCH --time=4:00:00
#SBATCH --output=gpu_job_%j.out
#SBATCH --error=gpu_job_%j.err

module purge
module load python/3.11.2

python3 train.py
```

The `--gres` format is `gpu:<type>:<count>`, for example:

- `--gres=gpu:p100:1` — one P100 GPU
- `--gres=gpu:a100:2` — two A100 GPUs on the same node
- `--gres=gpu:v100:1` — one V100 GPU

!!! warning "Avoid generic GPU requests"
    Using `--gres=gpu:1` without specifying a type lets Slurm assign any available GPU, which is often the most expensive. Always specify the GPU type.

---

## Step 4: Choose the right partition

| Account type | Partition to use |
| ---- | ---- |
| Credit account | `standard` |
| Paid allocation with GPU nodes | `sla-prio` |

For credit accounts, GPU nodes are in the `standard` partition. If you have a paid allocation that includes GPU nodes, use `--partition=sla-prio` instead.

---

## Step 5: Submit and verify the GPU is visible

Submit the job:

```bash
sbatch your_script.sh
```

To verify the GPU is accessible inside a running job, add `nvidia-smi` to your script before the main command:

```bash
nvidia-smi
python3 train.py
```

The output log will show GPU model, memory, and driver information if the GPU was allocated correctly.

---

## Step 6: Run an interactive GPU job (optional)

To get an interactive shell on a GPU node for testing:

```bash
salloc --nodes=1 --ntasks=4 --mem=16G --partition=standard --account=<account> --gres=gpu:p100:1 --time=01:00:00
```

Once on the compute node, run `nvidia-smi` to confirm GPU visibility, then test your code interactively.

---

## Tips

- Use `seff YOUR_JOB_ID` after a completed job to check GPU utilization. Low GPU utilization may indicate a bottleneck in data loading or preprocessing.
- If your application supports it, request only as many CPU cores as needed to feed the GPU — over-requesting CPUs wastes credits.

## Additional resources

- [Resource requests reference](../../running-jobs/resource-requests.md)
- [System Overview](../../system/system-overview.md)
- [Interactive jobs](../../running-jobs/interactive-jobs.md)
- [Contact ICDS support](../getting-help.md)
