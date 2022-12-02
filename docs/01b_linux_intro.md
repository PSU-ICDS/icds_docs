##### <span class="titlemark">5.1.1</span> Shells

Unix/Linux shells are command line interpreters that allow for a user to interact with their operating system through utility commands and programs. The Default Unix/Linux shell is BASH (the Bourne-Again SHell) which has extensive online documentation, and common or necessary commands are shown in the [Linux Quick Reference](#quick_ref).


Most commands have a manual that show all of the different ways the command can be used. For example,

`man ls`

shows all of the info for the `ls` command. You can use the arrows to scroll through the manual and the letter `q` for quit. Some commands will also provide a shortened version of the manual showing the available flags if an incorrect flag is used. For example,

`mam-list-funds -banana`

brings up a list of all of the flags available for `mam-list-funds`. Any non-working flag will allow for this. Note that this doesn’t give information about what the flags do, just what the flags are. This may be enough to remind you of something you had done previously.  

All shells utilize configuration files. For BASH, this is split between 2 files: `~/.bash_profile` and `~/.bashrc`.  
(NOTE: `~/` in Linux is a way to specify your own home directory!). The `.bash_profile` file is always parsed when a terminal is open, including with an SSH session. To connect the two in such a way that `.bashrc` will always be sourced for a session, make sure this code is included in your `~/.bash_profile`:

`if [ -f ~/.bashrc ]; then . ~/.bashrc fi`

##### <span class="titlemark">5.1.2</span> Alternative Shells

BASH is only the default shell, and it doesn’t come with quite a few features that many Linux power-users would like to have on the command-line. Other common shells include KSH (KornSHell), ZSH (Z SHell), and FISH (Friendly-Interface SHell). These shells all have documentation available online regarding their installation and customization.  



##### <span class="titlemark">5.1.3</span> Environmental Variables

Environment variables are values that pertain to certain aspects of an operating system’s configurations. These variables are typically used by utilities and programs for things like finding out where the user’s home directory is (`$HOME`) or where to look for executable files (`$PATH`). The prompt for BASH is held as the variable `PS1`.  

You can print the environment variable to the screen using the `echo` command:

`echo $HOME`

A good way to view environment variables that are set is by using the `env` command

`env`

which outputs all of the variables currently in use.  

To change the value of an existing variable or to create and set a new variable, we use `export`. For example, to set a variable called `workDir` to a directory called here within your home directory, the command would be:

`export workDir=$HOME/here`

Once this environment variable is set, you are able to use this. For example, to change to this directory, the command would be:

`cd $workDir`

For something like PATH where you really do not want to overwrite what values are already stored, you can append values with

`export PATH=$PATH:/new/dir/path/`

In lists of values, the colon (`:`) is used as the delimiter. The dollar sign (`$`) is used to reference variables, so that export command essentially appends the new directory to the list of existing directories searched for executables. It is possible to prepend as well, which may come in handy if you compile a different version of an existing command.  

For more general reading on environment variables in Linux, see these pages on [variables](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html) and [environmental variables](https://en.wikipedia.org/wiki/Environment_variable).  

The environment variables allow for script portability between different systems. By referencing variables like the home directory ($HOME) you can generalize a script’s functionality to work across systems and accounts.

|Variable Name|Description|
|--- |--- |
|USER|Your user ID|
|HOSTNAME|The name of the server that the script is being run on|
|HOME|Your home directory|
|WORK|Your work directory|
|SCRATCH|Your scratch directory|
|TMPDIR|The directory in which a job's temporary files are placed (created and deleted automatically)|


##### <span class="titlemark">5.1.4</span> References

The Linux terminal and submitting jobs are not unique to Roar. You can find many different training resources online for these. The Linux foundation offers [free training](https://training.linuxfoundation.org/free-linux-training). Lots of great information and tutorials for everyone from beginner Linux user to advanced users can be found [here](https://www.linux.org/pages/download/). Linux has been around for a long time. Therefore, any problem you might be having, someone has probably already had. It is always worthwhile to look around [stack exchange](https://unix.stackexchange.com/) to see if your question has already been answered.
