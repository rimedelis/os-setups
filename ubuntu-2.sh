#!/bin/bash

# Step 13: Packages to install
sudo apt install ubuntu-restricted-extras tlp git-all
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
cd ~/Downloads
wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_122.0.2365.92-1_amd64.deb
sudo apt install ./microsoft-edge-stable_122.0.2365.92-1_amd64.deb -y
sudo snap install code --classic

# Start TLP
sudo tlp start

# Step 14: Packages to uninstall
sudo snap remove firefox

# Step 15: Clean up afterwards
sudo apt autoclean
sudo apt clean
sudo apt autoremove

# Restart the computer for changes to apply
sudo reboot now

