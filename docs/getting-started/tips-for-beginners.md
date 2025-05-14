# Tips for beginners

!!! warning "Don't use submit nodes for heavy computing."
     Submit nodes are for preparing files, submitting jobs, 
     examining results, and transferring files.

!!! warning "Don't store files on scratch."
     [Scratch is not backed up](../file-system/file-storage.md/#quotas), 
     and files more than 30 days old are deleted.

!!! warning "Don't overrun your file storage quota."
     If you fill your allotted disk space, weird errors result.
     Keep an eye on your [disk space usage](../file-system/file-storage.md/#quotas).

!!! warning "Don't waste your compute resources."
     Use interactive sessions to test your workflow.
     Before a big batch job, run test jobs to make sure your code works.

## Roar uses Linux

The operating system for Roar is Red Hat Enterprise Linux 8 ([RHEL8][rhel8]),
a variant of Unix.
Unix a text-based; users interact with the system by typing commands.
Compute clusters use Linux
in part because tasks can be automated with scripts.
[rhel8]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9

This user guide assumes familiarity with Unix,
which any user who wants to do more than use the Portal needs to learn.
A tutorial website for Unix can be found [here][unix_tutorial].
[unix_tutorial]: https://www.tutorialspoint.com/unix/unix_tutorial.pdf
The first chapter of [this book][unixphysics] is also helpful.
An introduction to Unix
written for research undergraduates and graduate students,
is [here](../pdf/unixGuide.pdf).
[unixphysics]: https://www.oreilly.com/library/view/effective-computation-in/9781491901564/?sso_link=yes&sso_link_from=pennsylvania-state-university

See also the online lesson [HPC Carpentry lesson "Introduction
to Using the Shell in a HPC Context"](https://www.hpc-carpentry.org/hpc-shell/),
which can be followed after [logging onto Roar](connecting.md/#ssh).






