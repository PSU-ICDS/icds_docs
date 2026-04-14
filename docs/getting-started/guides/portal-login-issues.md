# How To: Fix Portal Login Issues

Use this guide if you cannot log in to the [Roar Collab portal](https://portal.hpc.psu.edu). Several distinct issues can prevent login—work through the steps below to identify and fix yours.

---

## Step 1: Confirm you have an active account

If you have never logged in before, you must first request a login account.

1. Follow the [account creation instructions](../connecting.md#login-accounts).
2. After submitting the form, you will receive a confirmation email.
3. You will receive a second email once your account has been created.

If you have not received these emails, check your spam folder or [contact ICDS](../getting-help.md).

---

## Step 2: Check if your home directory is over quota

The portal writes session and job files to your home directory. If your home directory is over quota, the portal may be unable to write those files and will block your login.

1. Use [Globus](http://www.globus.org) to view and manage the files in your home directory.
2. Delete or move files to free up space.
3. For detailed instructions on finding and fixing quota issues, see the [Quota Issues in $HOME guide](quota-issues-in-home.md).

!!! note
    Hidden directories (dotfiles such as `.conda`, `.local`) are common sources of large disk usage and may not be visible by default. Enable **Show Hidden Files** in Globus to see them.

---

## Step 3: Reset your portal session

Corrupted portal session files can prevent login. This issue usually self-corrects, but you can force a reset manually:

[Reset portal session](https://portal.hpc.psu.edu/nginx/stop?redir=/pun/sys/dashboard/){ .md-button }

After clicking the link, try logging in again.

---

## Step 4: Try a different browser or clear your cache

Local browser issues can interfere with authentication. Try each of the following:

1. Open a private or incognito window in your current browser.
2. Try a different browser entirely.
3. Clear your browser cache, including saved login sessions, and try again.

---

## Still having trouble?

If none of the steps above resolve your issue, [contact ICDS support](mailto:icds@psu.edu) with a description of what you tried and the error message you are seeing.
