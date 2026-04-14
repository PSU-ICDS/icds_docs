# How To: Transfer Large Files Using Globus

Use this guide to transfer files between Roar and another location (your laptop, Penn State OneDrive, or an external institution) using Globus. Globus is recommended for files larger than 1 GB.

---

## Step 1: Log in to Globus

1. Go to [globus.org](https://www.globus.org) and click **Log In**.
2. Search for and select **Pennsylvania State University** as your organization.
3. Log in with your Penn State credentials and complete multi-factor authentication.

---

## Step 2: Open the File Manager

After logging in, click **File Manager** in the left sidebar. You will see two panels side by side — the source on the left and the destination on the right.

---

## Step 3: Select the ICDS Roar endpoint

1. Click in the **Collection** search box in the left panel.
2. Search for **Penn State ICDS RC** and select it.
3. Log in if prompted.
4. Navigate to the directory containing the files you want to transfer (e.g., `/storage/work/abc123/mydata`).

ICDS Globus endpoints:

| Filesystem | Endpoint name |
| ---- | ---- |
| Roar | Penn State ICDS RC |
| Archive | Penn State ICDS Archive |
| PSU OneDrive | Penn State ICDS OneDrive |

---

## Step 4: Select the destination endpoint

In the right panel, click the **Collection** search box and select your destination:

- **Another ICDS filesystem** (e.g., Archive): search for the endpoint name in the table above.
- **PSU OneDrive**: search for **Penn State ICDS OneDrive**.
- **Your laptop**: see [Step 4a](#step-4a-set-up-globus-connect-personal-for-your-laptop) below.
- **Another institution**: search for the institution's Globus endpoint by name.

Navigate to the destination directory in the right panel.

---

## Step 4a: Set up Globus Connect Personal for your laptop

To transfer files to or from your own computer, install Globus Connect Personal:

1. Download and install the client for your operating system:
   - [Linux](https://docs.globus.org/globus-connect-personal/install/linux/)
   - [macOS](https://docs.globus.org/globus-connect-personal/install/mac/)
   - [Windows](https://docs.globus.org/globus-connect-personal/install/windows/)
2. Launch the client and log in with your Penn State credentials.
3. Follow the prompts to create a personal collection with a name you choose.
4. Back in the Globus web interface, search for that collection name in the right panel.

---

## Step 5: Select files and start the transfer

1. In the left panel (source), check the box next to each file or folder you want to transfer.
2. Click the **Start** button (arrow pointing toward the destination panel) to begin the transfer.
3. Globus will confirm the transfer has been submitted and begin moving the files in the background.

You do not need to keep your browser open — Globus continues the transfer on its own.

---

## Step 6: Monitor the transfer

Click **Activity** in the left sidebar to see the status of your transfer. You will also receive an email when the transfer completes or if it encounters an error.

---

## Tips

- Globus handles large transfers reliably and will automatically retry failed transfers due to transient network issues.
- For very large transfers (hundreds of GBs), schedule them during off-peak hours.
- If you need to share data with a collaborator, Globus Guest Collections allow you to grant access to specific directories. See [Transferring files](../../file-system/transferring-files.md) for details on authorized directories.

## Additional resources

- [Transferring files](../../file-system/transferring-files.md)
- [File storage](../../file-system/file-storage.md)
- [Contact ICDS support](../getting-help.md)
