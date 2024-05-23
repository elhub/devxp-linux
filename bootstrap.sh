#!/usr/bin/env bash
# Bootstrap script for devxp-linux. Run this the first time you set up your WSL system.

#Sync system and hardware clocks
sudo hwclock -s

# Upgrade the distro.
sudo apt-get update
sudo apt-get -y dist-upgrade

# Install tools.
sudo apt-get install -y make git python3 python3-pip

# Install Ansible via pip.
sudo apt-get remove -y ansible
sudo apt-get autoremove -y
python3 -m pip install --user ansible

# Ansible should now be installed in ~/.local/bin.
# If this directory did not exist already, then you might have to restart WSL.
# ~/.local/bin is conditionally loaded into $PATH in ~/.profile.

# Ensure that ~/.local/bin is loaded into $PATH.
source ~/.profile

# Run Ansible-runbooks to install necessary command-line tools.
ansible-galaxy install -r requirements.yml --force # pulls down necessary dependencies for Ansible.
ansible-playbook site.yml --ask-become-pass # installs devxp tools.
