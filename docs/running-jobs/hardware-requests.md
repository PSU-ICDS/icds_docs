# Hardware requests 

Users with paid [credit accounts or allocations](../accounts/paying-for-compute.md)
can request GPU nodes,
and fine-tune their hardware requests with `constraint` directives.

## GPUs

GPUs are only available to paid credit accounts,
or allocations that include GPU nodes.  
For a batch job paid by a credit account, to request a single GPU:

```
--partition=standard
--gres=gpu:1
```

To request n GPUs, replace 1 above by n.  
To request a specific model of GPU, use `--gres=gpu:a100:1`.

For an interactive job paid by a credit account, use `salloc`:
```
salloc -A <account> -p standard --gres=gpu:a100:1 ...
```

If the job is paid by an allocation, use `-p sla-prio` instead of `-p standard`.

For information on available GPU nodes, see [Compute hardware][hardware].
For the names of different GPU types (a100, a40, v100, p100,...)
see [Hardware info][hardwareinfo].
[hardware]: ../getting-started/compute-hardware.md
[hardwareinfo]: hardware-requests.md/#hardware-info

!!! warning "Make sure your application is GPU-enabled."
    If your application does not use GPUs,   
    requesting GPUs will do nothing except deplete your accounts.  

## Hardware info

Even within different hardware partitions, not all nodes on Roar are identical.
Often, software compiled for one type of CPU or GPU will not run on another, older type.

To find out about hardware on different nodes, there are several options.

If you are logged onto a compute node with an [interactive job][salloc], 
the command `lscpu` displays information about the CPUs;
`nvidia-smi` displays information about the GPUs (if present).
[salloc]: interactive-jobs.md

The SLURM command [`sinfo`][sinfo] displays information about *all* Roar nodes.
Its output is more easily read with some formatting options,
[sinfo]: https://slurm.schedmd.com/sinfo.html

```
sinfo --Format=features:30,nodelist:20,cpus:5,memory:10,gres:30
```

On Roar, `sinfo` output would look like:
```
AVAIL_FEATURES                NODELIST            CPUS MEMORY    GRES
bc,basic,broadwell,open       p-bc-[5001-5240]    24   126400    (null)
sc,standard,broadwell,open    p-hc-[6001-6002]    56   1024000   (null)
sc,standard,haswell,open      p-sc-[2337-2569]    24   257800    (null)
bc,basic,sapphirerapids       p-bc-[5401-5520]    64   255000    (null)
standard,a100_1g,mig,cascadelap-gc-3037           48   380000    gpu:a100_1g:14(S:0-11,36-47)
sc,standard,icelake           p-sc-[2169-2308]    48   512000    (null)
sc,standard,cascadelake       p-sc-[2001-2156]    48   380000    (null)
standard,a100,cascadelake     p-gc-[3001-3004,300648   380000    gpu:a100:2(S:0-11,36-47)
sc,standard,genoa             p-zc-[7001-7035]    64   380000    (null)
standard,a100_3g,mig,cascadelap-gc-3036           48   380000    gpu:a100_3g:4(S:0-11,36-47)
standard,a100_3g,a100_1g,cascap-gc-3005           48   380000    gpu:a100_3g:3(S:0-11,36-47),gp
standard,p100,broadwell       p-gc-[3101-3109,311228   256000+   gpu:p100:1(S:0-13)
standard,p100,broadwell       p-gc-[3110-3111,311328   256000    gpu:p100:1(S:14-27)
standard,v100,haswell         p-gc-[3192-3193]    24   256000    gpu:v100:1(S:0-11)
standard,v100,skylake         p-gc-[3201-3202]    28   770000    gpu:v100:4(S:0-27)
standard,a40                  p-ic-[4001-4012]    36   500000    gpu:a40:1(S:0-17)
hc,himem,icelake              p-sc-[2309-2336]    48   1024000   (null)
ma                            p-cl-0001           20   3045000   (null)
interactive,p100,broadwell    p-gc-[3161-3176]    28   256000    (null)
v100s,mri,mgc                 p-mc-[3470-3472]    40   1540000   gpu:v100s:10(S:0-39)
t4,nih,mgc                    p-mc-[3477-3480]    40   1540000   gpu:t4:16(S:0-39)
rtx6000,mri,mgc               p-mc-[3473-3474]    40   770000    gpu:rtx_6000:3(S:0-9,20-39)
v100nv,mri,mgc                p-mc-[3475-3476]    40   770000    gpu:v100:4(S:0-39)
```

Evidently, node attributes serve to identify nodes with a given

- CPU type (broadwell, haswell, ...)
- GPU type (a100, a40, v100, p100)
- partition (bc, sc, hc, gc, ic,...)
- specific hardware combinations (p100_256, 3gc20gb, ...)


## Constraints

Users with paid credit accounts and allocations can fine-tune their hardware requests 
with `constraint` directives.  In a batch script, constraints take the form:

```
#SBATCH --constraint=<feature>
```

where `<feature>` is one of the features listed by `sinfo` 
(or multiple features, separated by commas).
For example, to request `cascadelake` hardware, use `--constraint=cascadelake`.

For an [interactive job][salloc], constraints are given
with a `-C` option to `salloc`:

```
salloc -N 1 -n 4 -A <alloc> -C <feature> -t 1:00:00
```

!!!warning "Resource requests must match the allocation."
	For paid allocations, constraint directives
	must be consistent with the terms of the allocation.
	For credit accounts, any hardware can be requested.

