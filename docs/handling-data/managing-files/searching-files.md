# Finding files

On Macs and PCs, powerful tools exist for finding files
that match certain criteria, or contain certain text.

Two Unix commands that provide similar capabilities 
are [`find`][find] and [`grep`][grep].
[find]: https://man7.org/linux/man-pages/man1/find.1.html
[grep]: https://man7.org/linux/man-pages/man1/grep.1.html

`find` looks for files based on their *attributes* (name, type, size, date),
searches recursively (through all subdirectories of a given directory),
and returns a list of file names.

`grep` looks for files based on their *contents*,
searching locally by default (but can be made to search recursively),
and returns a list of lines that contain the searched-for pattern.

Like many Unix commands, 
find and grep have many option that expand their capabilities,
and can be combined with other Unix commands 
using pipes (`|`) and redirection (`>`) to perform complex tasks.

Tutorials exist for [Unix][unix_tutorial2], 
[grep][grep_tutorial], and [find][find_tutorial].
Google searches on these commands are often helpful
(e.g., "Unix how to find and delete large files").
Here are a few examples of each.
[unix_tutorial2]: https://www.tutorialspoint.com/unix/unix_tutorial.pdf
[grep_tutorial]: https://danielmiessler.com/p/grep/
[find_tutorial]: https://snapshooter.com/learn/linux/find

## Searching for Files (find)

Find all files with name that matches a pattern:
```
find . -name "*.trr"
```

Find files above a certain size:
```
find . -type f -size +100G
```

Find has a powerful option `-exec`,
which executes a command on files that are found.  
Use this with caution!  List the files first.

Find files, and then compress them:
```
find . -name "*.trr" -exec compress {} ; 
```

Find files of a certain type, get their sizes, and sum them:
```
find . -name "*.trr" -exec du -csh '{}' +
```

Find files of a certain type, get their sizes, and sort by size:
```
find . -name "*.trr" -exec du -sh '{}' + | sort -h -r
```

Find files above a certain size and list them: 
```
find . -type f -size +100G -exec ls -lh {} +
```

Find files of a certain extension and delete them: 
```
find . -name "*.trr" -exec rm -f {} +
```

## Searching In Files (grep)

In its simplest form, grep searches for a "pattern"
in a given file or set of files:
```
grep <pattern> <file>
```

In this form, grep finds all lines in `<file>` that contain `<pattern>`.
The pattern can have "wildcards" -- `*` matches anything, for example.

`<file>` can be a single filename, or itself a pattern
that matches multiple files; for example, `*.log` matches all logfiles.

grep is often useful to "filter" the output of commands.
`ps -e` lists all running processes (a very long list).
To look for any process that mentions `vmd`:
```
ps -e | grep vmd
```
`grep -R` searches recursively through subdirectories.
Here, grep searches the current directory `.` and its subdirectories,
including all files `*.sh`, looking for pattern `sed`, 
and writes the results to `sedExamples`: 
```
grep -R ‘.’ --include *.sh -e ‘sed’ > sedExamples
```
