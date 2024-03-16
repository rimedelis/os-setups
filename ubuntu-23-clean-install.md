# Clean Install -- Ubuntu 23

## Essential Steps

### Check for Updates (apt stands for aptitude. They say `apt` doesn't need to be preceeded by sudo as it automatically performs operations with superuser privileges when necessary.)

   ```bash
   sudo apt update && sudo apt upgrade

   # restart the computer for changes to apply
   sudo reboot now
   ```

### Enable additional repositories for more software

Search for Software & Updates.

Under the Ubuntu Software tab, make sure you have checked all the options: Main, Universe, Restricted and Multiverse repositories.

Move to the Other Software tab, check the option of Canonical Partners.

### Install all missing/additional drivers

Click on “Additional Drivers” Tab and follow the specific instructions provided on the screen.

### Install complete multimedia support

   ```bash
   sudo apt install ubuntu-restricted-extras
   ```

### Improve battery life by installing TLP

   ```bash
   sudo apt-get install tlp
   
   # or this one, with extra focus on Radio Device Wizard
   sudo apt-get install tlp tlp-rdw

   # Once installed, run this command
   sudo tlp start

   # To check the status of TLP and see its applied settings
   sudo tlp-stat

   # To make any customizations to TLP's settings, you can edit the configuration file (/etc/default/tlp) and then reload TLP with sudo tlp start to apply the changes
   ```

### Change Dock settings

   ```bash
   # Enable minimize when clicking on dock icons, and preview the opened windows of the same app when hovering over the icon
   gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'

   # Disable panel mode, making the dock float instead
   gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false

   # Dock on the bottom of the screen
   gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM

   # Dock without transparency effects
   gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED

   # Dock icons' size set to 64
   gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64

   # Dock icons become backlit
   gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items true

   # Auto-hide the Dock

   ```

### Enable Night Light and Dark Style

Settings > Screen Display > Night Light -- set to Sunset to Sunrise

Settings > Appearance > Dark Style

### Enable weather forecast on calendar's sidebar (check if equivalent snap exists?)

   ```bash
   sudo apt install gnome-weather
   ```

### Disable Startup Applications from the gnome app list

In the Startup Application Preferences, you can disable, add or remove the programs.

### Opt out of data collection in Ubuntu (optional)

System Settings > Privacy and then set the Problem Reporting to Manual or you can set it to Never.

### Add my profile photo to the lock screen

### Disable Bluetooth at startup (preferred)

    ```bash
    sudo systemctl disable bluetooth.service
    ```

### Disable Bluetooth at startup (alternative)

   Edit `/etc/bluetooth/main.conf` to:

   ```bash
   AutoEnable=false
   ```

### Enable Num Lock at startup

   ```bash
   gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
   ```

### Always show Hidden Files

   ```bash
   gsettings set org.gnome.nautilus.preferences show-hidden-files true
   ```

*(Snaps are more tightly integrated with Ubuntu specifically, whereas Flatpaks are developed for several Linux distros. However, both systems utilize sandboxing to isolate applications from the rest of the system. Their self-containment means that they can run independently of the system's installed libraries, reducing dependency issues and conflicts.)*

### Install Flatpak (adds the Software app (white icon, a shopping bag with 3 colorful geometric shapes) to the system. The only downside is that you’ll see multiple applications in Ubuntu software center. Flatpak applications are tagged with source dl.flathub.org and thus you can easily distinguish them.)

   ```bash
   # [Flatpak Setup](https://flatpak.org/setup/Ubuntu)
   sudo apt install flatpak
   sudo apt install gnome-software-plugin-flatpak
   # adds the Flathub repository. Flathub is the best place to get Flatpak apps
   flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
   ```

### Install Snap (current versions of Ubuntu have it preinstalled, it's the new App Center (orange icon), featuring only Debian and Snap apps from the Snapcraft store)

   ```bash
   sudo apt install snapd
   # to update all snaps
   sudo snap refresh
   ```

### Login to Ubuntu One account

### Show battery percentage

```bash
   gsettings set org.gnome.desktop.interface show-battery-percentage true
   ```

### Clean up afterwards

   ```bash
   # To remove the packages that failed to install completely,
   sudo apt-get autoclean

   # Additionally, to remove the apt-cache,
   sudo apt-get clean

   # Finally, to remove the unwanted software dependencies,
   sudo apt-get autoremove
   ```

### Disable startup programs at Startup Application Preferences

### Use apt-fast instead of apt (or apt-get, which is slowly becoming obsolete)

```bash
# Add the apt-fast PPA (Personal Package Archive) to the system's software sources.
# This repository provides the apt-fast package, which is a shell script wrapper for apt-get and aptitude
# that accelerates package downloads by using multiple connections per package.
sudo add-apt-repository ppa:apt-fast/stable

# Update the package index to ensure that the latest package lists from all repositories, including the newly added PPA,
# are available for installation.
sudo apt-get update

# Install the apt-fast package from the apt-fast PPA.
sudo apt-get install apt-fast
```

### Set up Livepatch

Allows to do major kernel updates without forcing the user to restart the machine. Only for users with Ubuntu One account.

Software & Updates > Livepatch

### Set Default Applications

Settings > Default Applications

### Install GS Connect: For Android Phone Users

### Setup Cloud Accounts

### Install GNOME Sushi for Quick Look feature (macOS)

### Enable Location Services

Settings > Privacy > Location Services

```bash
gsettings set org.gnome.system.location enabled true
   ```

### Enable Enchanced Tilling

Settings > Ubuntu Desktop > Enchanced Tilling

### Update Firmware via the Firware Updater app

### Adjust Mouse and Touchpad settings

Settings > Mouse & Touchpad -- increase Pointer Speed and enable Tap to Click

```bash
   gsettings set org.gnome.desktop.peripherals.mouse speed 1.0
   gsettings set org.gnome.desktop.peripherals.touchpad speed 1.0

   gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
   ```

## Programs to install

- As a rule, prefer snaps whenever available. For example, `sudo apt install package-name` installs the package version available in the Ubuntu repositories managed by APT (Advanced Package Tool). This version may be different from the version available as a snap package from the Snap Store, installable running the command `sudo snap install package-name`.

### Git

  ```bash
  # why use the apt-get instead of simply apt install?
  sudo apt-get install git-all
  ```

### Microsoft Edge (for most recent version, visit: <https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/>)

  ```bash
  cd ~/Downloads

  wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_122.0.2365.92-1_amd64.deb

  sudo apt install ./microsoft-edge-stable_122.0.2365.92-1_amd64.deb
  ```

### Google Chrome

  ```bash
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

  sudo apt install ./google-chrome-stable_current_amd64.deb
  ```

### VS Code (if installing via Snap, omit `--classic`) (or VSCodium)

  ```bash
  sudo snap install code --classic
  ```

### Thonny

```bash
# Unofficial snap
sudo snap install thonny
```

However, for my use case, I installed version 4.0.1, .deb package from the Software app (Flatpak/Flathub related app) because snap didn't let me install packages on Raspberry, didn't recognize the existence of the Raspberry.

#### In Thonny, to allow the Raspberry to run

```bash
sudo usermod -a -G dialout <username>
```

### VLC Player

   ```bash
   sudo snap install vlc
   ```

### GIMP?

   ```bash
   sudo snap install gimp
   ```

### FFmpeg

```bash
   sudo snap install ffmpeg
   ```

### Wine or Bottles (Wine is a compatibility layer that allows you to run Windows applications on Ubuntu)

   ```bash
   sudo apt install wine
   ```

### QBittorrent

```bash
# Unofficial snap
sudo snap install qbittorrent-arnatious
   ```

```bash
   sudo apt install qbittorrent
   ```

### SimpleScreenRecorder?

   ```bash
   sudo apt install simplescreenrecorder
   ```

### Virtual Machine Manager

   ```bash
   sudo apt install virt-manager
   ```

### Stacer

   ```bash
   sudo apt install stacer
   ```

### Obsidian

```bash
   sudo snap install obsidian --classic
   ```

### Discord

```bash
sudo snap install discord
```

### ufw - Uncomplicated Firewall

   ```bash
   sudo snap install ufw
   sudo ufw status
   
   # If disabled, run this command
   sudo ufw enable
   # This app allows control over our ports.
   # Example: if I'm running an SSH server on port 22 and I want to disable this port to prevent connections from remote computers, I'd use this command
   sudo ufw deny 22/tcp
   ```

## Extras

### In Anaconda

```bash
sudo apt-get install libgl1+libglx-mesa0 libegl1 libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

libgl1+libglx-mesa0 libegl1
```

### Prevent a Package From Being Updated in Ubuntu ([How to prevent a package from being updated in Ubuntu](https://itsfoss.com/prevent-package-update-ubuntu/))

#### Using aptitude

```bash
   # To hold a package and thus prevent apt from making changes to it
   sudo apt-mark hold package_name

   # To list all the packages that are held
   sudo apt-mark showhold

   # To remove hold on a package
   sudo apt-mark unhold package_name
   ```

#### Using the installable Synaptic Package Manager

```bash
   sudo apt install synaptic

   # The rest is done via the app's GUI.
   ```
