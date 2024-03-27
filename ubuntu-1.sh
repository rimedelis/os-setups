#!/bin/bash

# Step 1: Check for Updates
sudo apt update && sudo apt upgrade

# Step 2: Change Dock and Desktop settings
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.ding show-home false

# Step 3: Change Mouse and Touchpad settings
gsettings set org.gnome.desktop.peripherals.mouse speed 1.0
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.75
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# Step 4: Change Power settings
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'

# Step 5: Enable Num Lock at startup
gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true

# Step 6: Show Hidden Files
gsettings set org.gnome.nautilus.preferences show-hidden-files true

# Step 7: Enable Location Services
gsettings set org.gnome.system.location enabled true

# Step 8: Enable Night Light and Dark Style
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Restart the computer for changes to apply
sudo reboot now

