#!/bin/bash

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# updateKeys.sh
#
# This script will update your ssh keys
#
# Adam Lavely: adam.lavely@psu.edu
# 20 April 2017
#
# Use with the command:
# $ bash updateKeys.sh 
#
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Intro
curDate=$(date +"%d%b%Y-%T")
printf "#-#-#-#\n"
echo "This script will create a new ssh-key that will allow you to log onto the compute nodes without entering a password. The script is set-up to copy any existing files so that previous configuretions are not lost.  These files will include $curDate in the name and will be listed to the screen."

echo "The key will be created without a passphrase. You can exit this script and create your ssh key manually if you wish to use a passphrase.  Note that you will be prompted for this passphrase every time you or your script attempts to use an additional node, similar to requiring a password."

read -p "Are you sure you want to continue? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    echo "Starting the process..."
else
    exit 0
fi

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Check if files exist
printf "\n#-#-#-#\n"
echo "Checking if files exist..."
printf "\n"
if [ -e ~/.ssh/config ]
then
    echo "~/.ssh/config exists.  Moving the existing version to ~/.ssh/config.replaced.$curDate.  You can copy this back to revert to convert to the current configuration."
    mv ~/.ssh/config ~/.ssh/config.replaced.$curDate
else
    echo "~/.ssh/config does not exist.  It will be created in this process."
fi

printf "\n"
if [ -e ~/.ssh/authorized_keys ]
then
    echo "~/.ssh/authorized_keys exists.  Moving the existing version to ~/.ssh/authorized_keys.replaced.$curDate.  You can copy this back to revert to convert to the current configuration."
    mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys.replaced.$curDate
else
    echo "~/.ssh/authorized_keys does not exist.  It will be created in this process."
fi

printf "\n"
if [ -e ~/.ssh/id_rsa ]
then
    echo "~/.ssh/id_rsa exists.  Moving the existing version to ~/.ssh/id_rsa.replaced.$curDate.  You can copy this back to revert to convert to the current configuration."
    mv ~/.ssh/id_rsa ~/.ssh/id_rsa.replaced.$curDate
else
    echo "~/.ssh/id_rsa does not exist.  It will be created in this process."
fi

printf "\n"
if [ -e ~/.ssh/id_rsa.pub ]
then
    echo "~/.ssh/id_rsa.pub exists.  Moving the existing version to ~/.ssh/id_rsa.pub.replaced.$curDate.  You can copy this back to revert to convert to the current configuration."
    mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.replaced.$curDate
else
    echo "~/.ssh/id_rsa.pub does not exist.  It will be created in this process."
fi

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Create the key
printf "\n#-#-#-#\n"
echo "Creating your key..."
ssh-keygen -N "" -f ~/.ssh/id_rsa > ~/.ssh/$curDate.keyFingerprintAndRandomart
cp ~/.ssh/id_rsa ~/.ssh/id_rsa_$curDate
cp ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub_$curDate
echo "Your key fingerprint and randomart image were saved in ~/.ssh/$curDate.keyFingerprintAndRandomart"
 
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Authorize for this location (home is shared on the compute nodes)
printf "\n#-#-#-#\n"
echo "Setting up for use on the compute nodes..."
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Ensure that this is can be used
printf "\n#-#-#-#\n"
echo "Setting up the host key checking..."
echo "StrictHostKeyChecking no" > ~/.ssh/config

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Correct the permissions
printf "\n#-#-#-#\n"
echo "Updating the file permissions"
chmod 444 ~/.ssh/config
chmod 700 ~/.ssh

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Final messages - done and trial
printf "\n#-#-#-#\n"
echo "Done!"
printf "\n#-#-#-#\n"
