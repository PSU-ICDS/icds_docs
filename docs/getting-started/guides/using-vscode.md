# How To: Use VS Code to Edit and Run Code on Roar

Use this guide to connect Visual Studio Code on your laptop to Roar so you can edit files and run terminal commands on the cluster directly from your local editor.

---

## Step 1: Install VS Code on your laptop

Download and install [Visual Studio Code](https://code.visualstudio.com/) for your operating system (Windows, macOS, or Linux).

---

## Step 2: Install the Remote - SSH extension

1. Open VS Code.
2. Open the Extensions view: click the square icon in the left sidebar, or press `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (macOS).
3. Search for **Remote - SSH**.
4. Install the **Remote - SSH** extension published by Microsoft.

---

## Step 3: Configure your SSH connection

Adding a host entry to your SSH config file makes connecting to Roar a one-click operation.

1. Open the Command Palette: press `F1` or `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS).
2. Type and select **Remote-SSH: Open Configuration File...**.
3. Select your user SSH config file (usually `~/.ssh/config` on macOS/Linux, or `C:\Users\YourUser\.ssh\config` on Windows).
4. Add the following entry, replacing `<your-userid>` with your Penn State user ID:

```
Host roar
    HostName submit.hpc.psu.edu
    User <your-userid>
```

Save the file.

---

## Step 4: Connect to Roar

1. Open the Command Palette (`F1` or `Ctrl+Shift+P` / `Cmd+Shift+P`).
2. Type and select **Remote-SSH: Connect to Host...**.
3. Select **roar** from the list.
4. A new VS Code window opens. You will be prompted for your Penn State password and two-factor authentication, the same as a regular SSH login.
5. Once connected, **SSH: roar** appears in the bottom-left corner of the window.

---

## Step 5: Open a folder on Roar

1. In the connected VS Code window, go to **File → Open Folder...**.
2. Enter the path to the directory you want to work in (e.g., `/storage/work/abc123/myproject`).
3. Click **OK**. The folder opens in the VS Code file explorer.

---

## Step 6: Use the integrated terminal

Open a terminal on Roar directly in VS Code:

1. Go to **Terminal → New Terminal**, or press `` Ctrl+` `` (backtick).
2. The terminal opens a shell on the Roar submit node.

You can use this terminal to load modules, submit jobs, and run commands on Roar.

!!! warning "Do not run heavy computations in the VS Code terminal"
    The VS Code terminal connects to a submit node, which is shared and not intended for computation. For intensive work, submit [batch jobs](../../running-jobs/batch-jobs.md) or use `salloc` for an [interactive job](../../running-jobs/interactive-jobs.md).

---

## Step 7: Install extensions for your language (optional)

Extensions installed on your laptop are separate from extensions on the remote. To add language support (Python, R, etc.) on Roar:

1. Open the Extensions view.
2. Search for the extension you want (e.g., **Python**).
3. If the extension shows **Install in SSH: roar**, click that button.

---

## Tips

- If your connection is interrupted, reconnect using **Remote-SSH: Connect to Host...** from the Command Palette.
- Use `$WORK` as your working directory for project files to avoid filling your `$HOME` quota.
- The Remote - SSH extension installs a small VS Code server on Roar the first time you connect. This is stored in `~/.vscode-server` and may take a minute on first use.

## Additional resources

- [Visual Studio Code on Roar](../../software/visual-studio-code.md)
- [Connecting to Roar](../connecting.md)
- [Batch jobs](../../running-jobs/batch-jobs.md)
- [Contact ICDS support](../getting-help.md)
