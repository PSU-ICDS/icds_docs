# Connecting

## Roar Account Creation

Access to Roar requires a login account.
All users have access to user-level [storage space](../file-system/file-storage.md),
and a moderate amout of free credits in their user level [READ credit/Open account](../accounts/read-credits.md).

Anyone with a Penn State access ID can [request an account on Roar](https://accounts.hpc.psu.edu/users/).
Students and postdocs must be sponsored by a Penn State faculty member (their supervisor, advisor or collaborator). 
Once approved, you can connect to the Roar resources using your PSU credentials.

For external collaborators, 
Penn State faculty can set up [sponsored access accounts][sponsored],
which provides them with a Penn State access account and email address.
Once the sponsored account is active, a Roar account can be requested.
[sponsored]: https://security.psu.edu/services/penn-state-accts/sponsored/


## Two ways to access 

Roar can be accessed mainly using two ways:

 - via [the web-based Portal](#portal)
 - by using the "secure shell" ([`ssh`][ssh]) from a terminal application.
[ssh]: https://linux.die.net/man/1/ssh

The Portal (which runs [Open OnDemand](https://openondemand.org))
is designed mainly for interactive work.
It provides:

- a Windows-like desktop environment;
- a web-based file browser, to upload and download files;
- graphical, number-crunching programs, 
such as ANSYS, COMSOL, MATLAB, and RStudio.

The Portal is easy to use, 
because its preloaded programs can be launched and used without knowing Unix.
Its Windows-like desktop provides a familiar "feel"
for users accustomed to laptops (especially Linux laptops).
From its Terminal application,
users have access to the full capabilities of Roar,
needed to prepare and submit jobs.

Roar can also be accessed via SSH (Secure SHell),
from a terminal application on a laptop.


### Portal

For users who are unfamiliar with the Linux command line,
or who prefer an interactive graphical interface, 
the [Web Portal](https://portal.hpc.psu.edu) (which runs Open OnDemand) provides:

 - a file browser, for basic file editing and transfer
 - a graphical desktop environment with a familiar "look and feel"
 - software such as ANSYS, COMSOL, MATLAB, Star-CCM+, Jupyter, and RStudio avaialble under the "Interactive Apps" menu.
   
For advanced tasks, Portal users can access the command line interface under the "Clusters" menu called "_RC Shell Access".

### SSH

Alternatively, you can access the Roar via the ["secure shell" (SSH)](https://linux.die.net/man/1/ssh) 
from a terminal application.

On Windows, use the Command Prompt (installed by default), 
or an SSH client such as [PuTTY](https://www.putty.org) 
or [MobaXterm](https://mobaxterm.mobatek.net/).
On MacOS, use the Terminal (installed by default), 
or an SSH client such as [iTerm](https://iterm2.com).

From the terminal, log on to a submit node using the command
<br> `ssh <userid>@submit.hpc.psu.edu`
<br> Authenticate using your PSU userid and password, then with multi-factor authentication (MFA),
which verifies your identity.
To set up MFA, visit the [PSU accounts portal](https://accounts.psu.edu/2fa).

#### X forwarding

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


on the PC, use [Notepad++](https://notepad-plus-plus.org).

## Text editors

Linux is a text-based operating system;
programs, batch scripts, and parameter files are text files.
To work on Linux, you need a good text editor.  
There are several options available, depending on your preferences and how you're accessing the system.  

### Terminal based editors

`vi` is beloved by old-school users.
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

### GUI editors
For coding projects,
a popular choice is [Visual Studio Code Server][vscode]
(available as "Code Server" from the Portal main page under Interactive Apps).
Not just an editor, VSCode is an Integrated Development Environment,
that checks for errors as you type,
runs Python code interactively, has a debugger, and so on.
[vscode]: https://code.visualstudio.com/docs/remote/vscode-server

Files can be created or edited on your laptop and then transferred to Roar. 
If you choose to do this, be sure to use a plain text editor, not a word processor like Microsoft Word.
On the Mac, use [BBEdit](https://www.barebones.com/products/bbedit/);
On PC, use [Notepad++](https://notepad-plus-plus.org)

Alternatively, files can also be edited directly through the Roar portal under the Files section.


