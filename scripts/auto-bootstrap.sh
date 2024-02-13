#!/usr/bin/env bash
# Automated bootstrap script for devxp-linux. Run this the first time you set up your WSL system.

# Navigate to the directory containing the script
cd "$(dirname "$0")" || exit

# Perform a git pull to update the repository
git pull

# Check if the git pull was successful
if [ $? -ne 0 ]; then
    echo "Failed to update the repository. Please check your network connection and try again."
    exit 1
fi


# Read the user from the file
USER=$(cat /usr/local/bin/user)

# Upgrade the distro.
apt-get update
apt-get -y dist-upgrade

# Install tools.
apt-get install -y make git python3 python3-pip

# Install Ansible via pip.
apt-get remove -y ansible
apt-get autoremove -y
python3 -m pip install ansible

# Ansible should now be installed in ~/.local/bin.
# If this directory did not exist already, then you might have to restart WSL.
# ~/.local/bin is conditionally loaded into $PATH in ~/.profile.

# Ensure that ~/.local/bin is loaded into $PATH.
source ~/.profile

# Run Ansible-runbooks to install necessary command-line tools.
/root/.local/bin/ansible-galaxy install -r /usr/local/bin/devxp-linux/requirements.yml --force # pulls down necessary dependencies for Ansible.
/root/.local/bin/ansible-playbook /usr/local/bin/devxp-linux/site.yml --user="$USER" # installs devxp tools.
