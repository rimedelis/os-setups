#!/bin/bash

# Update package lists and upgrade installed packages
echo "Updating package lists and upgrading installed packages..."
sudo apt update && sudo apt upgrade

# Remove packages that failed to install completely
echo "Removing packages that failed to install completely..."
sudo apt autoclean

# Remove apt-cache
echo "Removing apt-cache..."
sudo apt clean

# Remove unwanted software dependencies
echo "Removing unwanted software dependencies..."
sudo apt autoremove

echo "Update and cleanup process completed."

