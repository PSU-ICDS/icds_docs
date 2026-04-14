# How To: Fix a "Permission Denied" Error

Use this guide when you see a `Permission denied` error while trying to read, write, or execute a file or directory. This error means your user account does not have the rights to perform the requested action.

---

## Step 1: Identify the cause

Read the error message carefully. Note the file or directory path mentioned. The most common causes are:

- You are trying to run a script that is not executable
- You are trying to write to a directory you do not own
- You are trying to access group storage you have not been granted access to

---

## Step 2: Follow the fix for your situation

### The file is a script you are trying to run

New files do not have execute permission by default. Add it with `chmod`:

```bash
chmod +x your_script.sh
```

Then run the script again.

### You are trying to write to a directory

You can only write to your own personal storage directories. Confirm your script is writing to one of:

- `$HOME` — your home directory
- `$WORK` — your work directory
- `$SCRATCH` — your scratch directory

If your script is writing to a system directory or another user's directory, update it to use one of your personal paths instead.

### You are trying to access group storage

By default, users are not added to any groups. If you need access to a group storage directory:

1. Contact the PI or owner of that storage space.
2. Ask them to grant you access.
3. Once access is granted, try again.

---

## Step 3: Verify the fix

Re-run the command or script that produced the error. If the error persists after following the steps above, [contact ICDS support](../getting-help.md) for further assistance.
