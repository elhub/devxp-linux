#!/usr/bin/env bash
# Bootstrap script for devxp-linux. Run this the first time you set up your WSL system.

# Upgrade
sudo apt update
sudo apt-get -y dist-upgrade

# Python
sudo apt update
sudo apt install -y git python3 python3-pip

# Ansible
sudo apt remove -y ansible
sudo apt autoremove -y
python3 -m pip install --user ansible

# Other
sudo apt install -y make

echo ""
echo "    Ansible should now be installed in ~/.local/bin."
echo "    If this directory did not exist already, then you might have to restart WSL."
echo "    ~/.local/bin is conditionally loaded into \$PATH in ~/.profile"
echo ""
