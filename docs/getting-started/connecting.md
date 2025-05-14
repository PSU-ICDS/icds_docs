# Connecting

## Login accounts

Access to Roar requires a login account.
All users have access to user-level [storage space](../file-system/file-storage.md),
and free access to the open queue.

Anyone with a Penn State access ID can [request an account on Roar](https://accounts.hpc.psu.edu/users/).
Students and postdocs must be sponsored by a Penn State faculty member (their supervisor, advisor or collaborator). 
Once approved, you can connect to Roar using your PSU credentials.

For external collaborators, 
Penn State faculty can set up [sponsored access accounts][sponsored],
which provides them with a Penn State access account and email address.
Once the sponsored account is active, a Roar account can be requested.
[sponsored]: https://security.psu.edu/services/penn-state-accts/sponsored/

## Portal

For users who are unfamiliar with the Linux command line,
or who prefer an interactive graphical interface, 
the [Web Portal](https://portal.hpc.psu.edu) (which runs Open OnDemand) provides:

 - a file browser, for basic file editing and transfer
 - a graphical desktop environment with a familiar "look and feel"
 - software such as ANSYS, COMSOL, MATLAB, VS Code, Jupyter, and RStudio
   
For advanced tasks, Portal users can access the command line interface under the "Clusters" menu.

## SSH

Alternatively, you can access the Roar via ["secure shell" (SSH)](https://linux.die.net/man/1/ssh) 
from a terminal application.

On Windows, use the Command Prompt (installed by default), 
or an SSH client such as [PuTTY](https://www.putty.org) 
or [MobaXterm](https://mobaxterm.mobatek.net/).
On MacOS, use the Terminal (installed by default), 
or an SSH client such as [iTerm](https://iterm2.com).

From the terminal, log on to a submit node using the command
<br> `ssh <userid>@submit.hpc.psu.edu`
<br> Authenticate using your PSU userid and password, then with multi-factor authentication (MFA),
which confirms that you are you.
To set up MFA, visit the [PSU accounts portal](https://accounts.psu.edu/2fa).

## X forwarding

To use any Roar application that "opens a window"
(an  "X Window" or "X11" application), 
you must install an additional program on your laptop.

On a Mac, install [XQuartz](https://www.xquartz.org);
on a PC, install [VcXsrv](https://sourceforge.net/projects/vcxsrv/)
or [MobaXterm](https://mobaxterm.mobatek.net/).

Then, log on with option `-X` for "X forwarding":
`ssh -X <userid>@submit.hpc.psu.edu`

When you log on to Roar from off-campus,
X Window applications can sometimes be slow to update the display;
the [Portal](../running-jobs/portal.md)  works better in such circumstances.

## Text editors

Linux is a text-based operating system;
programs, batch scripts, and parameter files are text files.
To work on Linux, you need a good text editor.  There are several options.  

`gedit` is a Windows-style text editor,
reasonably intuitive for Windows and Mac users,
available on the Portal Interactive Desktop
(under Applications/Accessories/Text Editor),
or via `ssh -X`.

Other Linux editors are [`emacs`][emacs]
(under Applications/Accessories/emacs, or via `ssh -X`)
and [`nano`][nano] (from the command line, via `ssh -X`).
[emacs]: https://www.gnu.org/software/emacs/
[nano]: https://www.nano-editor.org

For coding projects,
a popular choice is [Visual Studio Code Server][vscode]
(available as "VS Code Server" from the Portal main page).
Not just an editor, VSCode is an Integrated Development Environment,
that checks for errors as you type,
runs Python code interactively, has a debugger, and so on.
[vscode]: https://code.visualstudio.com/docs/remote/vscode-server

Finally, `vi` is beloved by old-school users.
In vi, you navigate within a file by key commands.
vi offers powerful search-and-replace,
and rapid navigation within the file.
Learning vi is like touch-typing -- 
difficult at first, but remarkably fast.  

Tutorials for vi are available [here][vi1] and [here][vi2].
Once you know vi, [this summary][vi_summary] is useful.
[vi1]: https://www.cs.colostate.edu/helpdocs/vi.html 
[vi2]: http://heather.cs.ucdavis.edu/~matloff/UnixAndC/Editors/ViIntro.html
[vi_summary]: https://bpb-us-e1.wpmucdn.com/sites.psu.edu/dist/0/79295/files/2020/09/notes-on-vi.pdf

Files can be edited on the laptop and transferred to Roar.
If you do this, you must use a text editor, not a word processor.
On the Mac, use [BBEdit](https://www.barebones.com/products/bbedit/);
on the PC, use [Notepad++](https://notepad-plus-plus.org).

