# Transferring files

Computational workflows often require files 
on Roar RC, Roar archival storage, 
OneDrive, or your laptop or desktop machine
to be transferred -- copied from one place to another.

Transfers to and from Roar Restricted follow a special protocol,
described [here](../../roar-restricted/rr-handling-data.md).

Multiple tools exist to perform these file transfers.
No single tool is best for all cases;
below, we recommend methods, 
and list approximate transfer rates for large files.

| Transfer | Method | Relative Rate |
| ---- | ---- | ---- |
| RC &harr; Archive | Globus | slow |
| RC &rarr; OneDrive | Firefox in an Open On Demand session or Globus | slow | 
| OneDrive &rarr; RC | Firefox in an Open On Demand session or Globus | slow |
| RC &harr; laptop | Portal Files menu | moderate |
| RC &harr; laptop | Cyberduck or FileZilla | moderate |
| OneDrive &harr; laptop | Local Web Browser | slow |
| RC &harr; most globus collections | Globus | fast |

These are typical but not universal results. Transfers will be limited by the slowest intervening networking or storage componenet.
