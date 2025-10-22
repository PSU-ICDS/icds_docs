# How to Write Good Support Requests

Writing clear, complete support requests isn’t just courteous — it gets you help **faster**.

We receive many requests daily. The clearer your message, the quicker we can understand and resolve your issue.

Below are best practices to follow.

## Never Email Staff Directly

Always use either: 
- **Email**: <icds@psu.edu>
- **Service Portal**: [https://pennstate.service-now.com/sp?id=sc_cat_item&sys_id=dd1c98f11b57e510bd31ed74bd4bcb1a](https://pennstate.service-now.com/sp?id=sc_cat_item&sys_id=dd1c98f11b57e510bd31ed74bd4bcb1a)
- **Support Ticket** : Submit through the Roar portal

These channels are **tracked**, **prioritized**, and **visible to the entire team**. Direct emails to individuals may be missed or delayed — especially if that person works support only part-time.


## Don’t Treat Us Like a Search Engine

Before contacting us:
- Search the **exact error message** + your software name
- Check the [Roar User Guide](../README.md)
- Look in the software documentation

> *We do this too — it’s often the fastest way to solve a problem.*


## Use a Descriptive Subject Line

Bad: `Problem with software on Roar`  
Good: `GROMACS MPI fails to launch on 4 nodes (RC) – srun: error: Unable to allocate resources`

The subject is the **first thing we see**. A clear subject helps us:
- Prioritize
- Assign to the right expert
- Respond faster


## One Issue = One Email

Do **not** reply to an old, unrelated ticket.

Every support request gets a **ticket number** in the subject line (e.g., `INC123456`). Replying to the wrong thread:
- Files your issue under the wrong case
- Risks it being overlooked

Start a **new email or ticket** for each new problem.


## Avoid the XY Problem

Read: [https://xyproblem.info](https://xyproblem.info)

**In short**:
> You want to do **X**.  
> You think **Y** will help, but don’t know how to do **Y**.  
> You ask about **Y**.  
> We waste time on **Y**, only to learn you wanted **X** — and **Y** wasn’t even the right approach.

**Fix**: Tell us **both**:
- What you’re trying to **achieve (X)**
- What you’ve tried (**Y**)

We may know a better, faster way to reach **X**.


## Tell Us What *Has* Worked

Don’t just say:  
> “I can’t run X on two nodes.”

Instead, include:
- Did it work on **1 node**? **1 core**?
- Did it **ever work** before?
- What have you **already tried** to debug?

This helps us **isolate the problem** and avoid unnecessary back-and-forth.


## Specify Your Environment

Include:
- Did you or a colleague **compile the code**?
- Which **modules** were loaded? (`module list`)
- Are you using **non-default modules**?

If we debug in a different environment, we waste time.


## Simple Cases: Be Specific

Never say:  
> “X didn’t work.”

Instead, provide:
```bash
# Exact command
srun -n 8 ./mycode input.dat

# Full error output
srun: error: Unable to allocate resources: Invalid account


The better your request, the faster we help — and often, you’ll solve it yourself in the process.