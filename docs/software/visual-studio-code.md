# Visual Studio Code

Visual Studio Code (VS Code) is a popular code editor 
that can edit files and run code on Roar. <br>
You can use VS Code on the [Portal](../running-jobs/portal.md), 
or install it on your laptop 
and connect to Roar via `ssh`.

## Prerequisites

Before you begin, install on your local machine:

* [Visual Studio Code](https://code.visualstudio.com/);
* an [SSH client](../getting-started/connecting.md/#ssh);
* software for [X forwarding](../getting-started/connecting.md/#x-forwarding).

## Installation

1.  Open Visual Studio Code on your local machine.
2.  Go to the **Extensions** view by clicking on the square icon in the sidebar, <br> 
or pressing `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (macOS).
3.  Search for "Remote - SSH".
4.  Install the extension **Remote - SSH** by Microsoft.

## Configuration

To connect to Roar easily, adjust your SSH config file:

1.  In VS Code, open the Command Palette, with `F1` or `Ctrl+Shift+P` (Windows/Linux) <br>
or `Cmd+Shift+P` (macOS). 
2.  Type and select **Remote-SSH: Open Configuration File...**.
3.  Select your user config file (usually `~/.ssh/config` or `C:\Users\YourUser\.ssh\config`).
4.  Add the following host entry:

```ssh
Host roar
    HostName submit.hpc.psu.edu
    User <your-userid>
```

## Connecting

1.  Open the Command Palette (`F1` or `Ctrl+Shift+P` / `Cmd+Shift+P`).
2.  Type and select **Remote-SSH: Connect to Host...**.
3.  Select **roar** (or whatever name you gave `Host` in your config file).
4.  A new VS Code window will open. You will be prompted for your password,
and for two-factor authentication as for any login.
5.  Once connected, "SSH: roar" will appear in the bottom-left corner of the window.

## Usage tips

-   **File Editing**: You can open folders and files on Roar in VS Code, from **File > Open Folder...**.
-   **Terminal**: You can run commands on Roar from the VS Code terminal.
-   **Extensions**: You can install extensions for the remote environment.

!!! warning "Heavy computations"
    Do not run heavy computational tasks on login nodes (where VS Code logs in). 
    For intensive work, submit [batch jobs](../running-jobs/batch-jobs.md) 
    or use an [interactive job](../running-jobs/interactive-jobs.md).
