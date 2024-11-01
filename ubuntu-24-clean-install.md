# Clean Install -- Ubuntu 24

### 0. If the PC is running Windows, go to `Control Panel\Hardware and Sound\Power Options\System Settings`, and under "Shutdown settings", uncheck "Turn on fast startup (recommended)" in order to disable fast startup. It's also mandatory to disable "Secure Boot" and recommended to disable "Fast Boot" in BIOS.

### 0.1 To be able to boot successfully from USB on my laptop, the trick is to simultaneouly insert the USB flash drive and press F9, right before the screen first lights up after restart, or else the device won't appear on the boot list. On Lenovo laptops, restart the PC and press F12 (Fn+F12). I also find it best to remove any other USB devices connected to the laptop.

Flashing a Linux image typically involves creating a bootable USB drive or SD card with the Linux distribution's installation files. Once the image is flashed onto the drive, it becomes formatted in a filesystem format that may not be natively supported by Windows or macOS.

Windows typically uses NTFS or FAT32 filesystems, while macOS uses HFS+ or APFS. Linux distributions often use filesystems like ext4.

Here's how to fix this: <https://blog.balena.io/did-etcher-break-my-usb-sd-card/>

### Tip: execute [ubuntu-1.sh](https://github.com/rimedelis/os-setups/blob/4860916e4dbcad4c4c6dd464b116720b5d4ec597/ubuntu-1.sh) to automate steps 1 to 8.

### 1. Check for updates (`apt` stands for Advanced Package Tool. In truth, `apt` doesn't need to be preceeded by `sudo` as it automatically performs operations with superuser privileges when necessary, but it's still standard to type it, to guarantee that the commands run successfully in all situations.)

```bash
sudo apt update && sudo apt upgrade
```

### 2. Change Dock and Desktop settings

```bash
# Enable minimize when clicking on dock icons, and preview the opened windows of the same app when hovering over the icon
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'

# Disable panel mode, making the dock float instead
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false

# Dock on the bottom of the screen
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM

# Hide "Trash" icon
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

# Hide "Volumes and Devices" icons
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false

# Auto-hide the Dock
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true

# Hide "Home" folder icon on desktop
gsettings set org.gnome.shell.extensions.ding show-home false
```

### 3. Change Mouse and Touchpad settings

Under "Mouse & Touchpad", increase "Pointer Speed", set "Secondary Click" to "Two Finger Push" and check if "Tap to Click" is enabled.

```bash
gsettings set org.gnome.desktop.peripherals.mouse speed 1.0
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.75

gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'

gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```

### 4. Change Power settings

Under "Power", disable "Dim Screen", set "Screen Blank" to "Never", enable "Show battery percentage", disable "Automatic Suspend" and set "Power Button Behavior" to "Suspend".

```bash
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

gsettings set org.gnome.desktop.session idle-delay 0

gsettings set org.gnome.desktop.interface show-battery-percentage true

gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
```

### 5. Enable Num Lock at startup

```bash
gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
```

### 6. Show Hidden Files

Go to "Files" and under "Main Menu", enable "Show Hidden Files" (or press Ctrl+H).

```bash
# This command is obsolete.
gsettings set org.gnome.nautilus.preferences show-hidden-files true
```

### 7. Enable Location Services

Under "Privacy", enable "Location Services".

```bash
gsettings set org.gnome.system.location enabled true
```

### 8. Enable Night Light and Dark Style

Under "Screen Display", enable "Night Light" and set it to "Sunset to Sunrise".

```bash
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
```

Under "Appearance", check if "Dark Style" is enabled.

```bash
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### Restart the computer for changes to apply: `sudo reboot now`

### 9. Enable Enhanced Tilling

Under "Ubuntu Desktop", check if "Enhanced Tilling" is enabled.

### 10. Opt out of data collection

Under "Privacy", go to "Diagnostics" and set "Problem Reporting" to "Never".

### 11. Change Software & Updates settings

Use the Super Key to open the Activities overview and search for "Software & Updates":

- Under "Ubuntu Software", check if enabled: "Main", "Universe", "Restricted" and "Multiverse" repositories.

- Under "Updates", set "When there are other updates" to "Display immediately".

- Under "Additional Drivers", check if updates are available.

### 12. Update firmware via the Firmware Updater app

### Tip: execute [ubuntu-2.sh](https://github.com/rimedelis/os-setups/blob/4860916e4dbcad4c4c6dd464b116720b5d4ec597/ubuntu-2.sh) to automate steps 13 to 15

### 13. Packages to install

- In recent versions of Ubuntu, the Snap package manager (snapd) is preinstalled by default -- it's the new App Center (orange icon), featuring only Debian and Snap apps from the Snapcraft store. As a rule, prefer snaps whenever available.

- For example, `sudo apt install package-name` installs the package version available in the Ubuntu repositories managed by APT (Advanced Package Tool). This version may be different from the version available as a snap package from the Snap Store, installable running the command `sudo snap install package-name`.

- To manually fetch the latest versions of installed snaps from the Snap Store and update them: `sudo snap refresh`.

#### ubuntu-restricted-extras -- software package for the computer operating system Ubuntu that allows the user to install essential software which is not already included due to legal or copyright reasons

```bash
sudo apt install ubuntu-restricted-extras
```

#### TLP -- command line utility for Linux, saving laptop battery power

```bash
sudo apt-get install tlp

# Once installed, run this command
sudo tlp start

# To make any customizations to TLP's settings, you can edit the configuration file (/etc/default/tlp) and then reload TLP with sudo tlp start to apply the changes
```

#### Google Chrome -- web browser

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo apt install ./google-chrome-stable_current_amd64.deb
```

#### Git -- distributed version control system

```bash
sudo apt install git-all

# Username and email address must be configured before Git can be used
git config --global user.name "rimedelis"
git config --global user.email email@example.com
```

#### Microsoft Edge (for most recent version, visit this page and then edit the link in the command below: <https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/>) -- web browser

```bash
cd ~/Downloads

wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_122.0.2365.92-1_amd64.deb

sudo apt install ./microsoft-edge-stable_122.0.2365.92-1_amd64.deb
```

#### Visual Studio Code (or VSCodium) -- source-code editor

```bash
sudo snap install code --classic
```

#### Flutter -- UI toolkit for building natively compiled applications

```bash
sudo snap install flutter --classic
```

#### OpenJDK 21 -- Java Development Kit

```bash
sudo apt install openjdk-21-jdk
```

#### Android Command Line Tools

Please install the Android Command Line Tools manually from the [official website](https://developer.android.com/studio).

#### Google Android Platform Tools

```bash
sudo apt install google-android-platform-tools-installer
```

#### Node.js -- JavaScript runtime built on Chrome's V8 JavaScript engine

```bash
sudo snap install node --classic
```

#### LAMP Stack -- Linux, Apache, MySQL, PHP

```bash
sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql

# The default web directory for Apache is /var/www/html. Copy the backend folder to /var/www/html:
sudo cp -r ~/Documents/php_base /var/www/html/

# Set Permissions so Apache can access the folder:
sudo chown -R www-data:www-data /var/www/html/php_base
sudo chmod -R 755 /var/www/html/php_base

# Install dependencies for Composer
sudo apt install php-cli unzip curl -y

# Download the Composer installer
curl -sS https://getcomposer.org/installer -o composer-setup.php

# Run the installer
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Add the Directory to Git’s Safe Directories
git config --global --add safe.directory /var/www/html/php_base

# Set Directory Permissions and Ownership
# Change ownership of the directory to your user (if it’s currently set to root or www-data)
sudo chown -R $USER:$USER /var/www/html/php_base

# Set correct permissions
sudo chmod -R 755 /var/www/html/php_base

# Run composer for the backend folder to install the dependencies listed in the composer.json file
composer install
```

### 14. Packages to uninstall

Open "App Center" and uninstall:

```bash
# Firefox
sudo snap remove firefox
```

### 15. Clean up afterwards

```bash
# To remove the packages that failed to install completely,
sudo apt autoclean

# Additionally, to remove the apt-cache,
sudo apt clean

# Finally, to remove the unwanted software dependencies,
sudo apt autoremove
```

### Restart the computer for changes to apply: `sudo reboot now`

### 16. Change Default Applications

Under "Settings", set the Default Applications.

### 17. Disable Startup Applications

Under "Startup Application Preferences", disable or remove the programs.

### 18. Login to Ubuntu One account

<https://login.staging.ubuntu.com/>

### 19. Add Online Accounts

Under "Online Accounts", select an account from the list.

### 20. Change login screen photo

Under "Users", edit the login screen photo.

### Restart the computer for changes to apply: `sudo reboot now`

### Optional packages and extras

#### Flatpak (adds the Software app (white icon, a shopping bag with 3 colorful geometric shapes) to the system. The only downside is that you’ll see multiple applications in Ubuntu software center. Flatpak applications are tagged with source dl.flathub.org and thus you can easily distinguish them.)

Note: Snaps are more tightly integrated with Ubuntu specifically, whereas Flatpaks are developed for several Linux distros. However, both systems utilize sandboxing to isolate applications from the rest of the system. Their self-containment means that they can run independently of the system's installed libraries, reducing dependency issues and conflicts.

```bash
# [Flatpak Setup](https://flatpak.org/setup/Ubuntu)
sudo apt install flatpak

sudo apt install gnome-software-plugin-flatpak

# adds the Flathub repository. Flathub is the best place to get Flatpak apps
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

#### Enable weather forecast on calendar's sidebar (check if equivalent snap exists?)

```bash
sudo apt install gnome-weather
```

#### Enable Livepatch (eliminates the need for unplanned maintenance windows for kernel vulnerabilities, by patching the Linux kernel while the system runs. Livepatch is included in Ubuntu Pro)

Under "Software & Updates", enable "Livepatch".

Check [How to enable the Livepatch client](https://ubuntu.com/security/livepatch/docs/livepatch/how-to/enable).

#### Stacer -- system optimizer and application monitor

```bash
sudo apt install stacer
```

#### Use apt-fast instead of apt (or apt-get, which is slowly becoming obsolete)

```bash
# Add the apt-fast PPA (Personal Package Archive) to the system's software sources.
# This repository provides the apt-fast package, which is a shell script wrapper for apt-get and Aptitude
# that accelerates package downloads by using multiple connections per package.
sudo add-apt-repository ppa:apt-fast/stable

# Update the package index to ensure that the latest package lists from all repositories, including the newly added PPA,
# are available for installation.
sudo apt-get update

# Install the apt-fast package from the apt-fast PPA.
sudo apt-get install apt-fast
```

#### Thonny -- IDE for Python designed for beginners

```bash
# Unofficial snap
sudo snap install thonny
```

However, for my use case, I installed version 4.0.1, .deb package from the Software app (Flatpak/Flathub related app) because snap didn't let me install packages on Raspberry, didn't recognize the existence of the Raspberry.

##### In Thonny, to allow the Raspberry to run

```bash
sudo usermod -a -G dialout <username>
```

#### SimpleScreenRecorder -- record programs and games

```bash
sudo apt install simplescreenrecorder
```

#### Virtual Machine Manager -- managing virtual machines through libvirt

```bash
sudo apt install virt-manager
```

##### AutoCAD inside a Windows VM

#### GIMP -- cross-platform image editor

```bash
sudo snap install gimp
```

#### FFmpeg -- record, convert and stream audio and video

```bash
sudo snap install ffmpeg
```

#### Wine or Bottles (Wine is a compatibility layer that allows you to run Windows applications on Ubuntu)

```bash
sudo apt install wine
```

#### QBittorrent -- open-source BitTorrent client

```bash
# Unofficial snap
sudo snap install qbittorrent-arnatious
```

```bash
sudo apt install qbittorrent
```

#### Diodon -- clipboard manager

```bash
sudo add-apt-repository ppa:diodon-team/stable

sudo apt update
```

#### ufw -- uncomplicated firewall

```bash
sudo snap install ufw

sudo ufw status

# If disabled, run this command
sudo ufw enable

# This app allows control over our ports.
# Example: if I'm running an SSH server on port 22 and I want to disable this port to prevent connections from remote computers, I'd use this command
sudo ufw deny 22/tcp
```

#### GitHub CLI + Copilot

[Using GitHub Copilot in the CLI](https://docs.github.com/en/copilot/github-copilot-in-the-cli/using-github-copilot-in-the-cli)

#### GS Connect -- for Android Phone Users

#### GNOME Sushi -- for Quick Look feature (similar to macOS)

### Tips and tricks

#### In Anaconda

```bash
sudo apt-get install libgl1+libglx-mesa0 libegl1 libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

libgl1+libglx-mesa0 libegl1
```

#### Prevent a Package From Being Updated in Ubuntu ([How to prevent a package from being updated in Ubuntu](https://itsfoss.com/prevent-package-update-ubuntu/))

This can be done using Aptitude or SPM:

##### Using Aptitude

```bash
# To hold a package and thus prevent apt from making changes to it
sudo apt-mark hold package_name

# To list all the packages that are held
sudo apt-mark showhold

# To remove hold on a package
sudo apt-mark unhold package_name
```

##### Using the installable Synaptic Package Manager

```bash
sudo apt install synaptic

# The rest is done via the app's GUI.
```

### Uninstalling Ubuntu

To uninstall Ubuntu and delete dual boot in Windows: <https://www.youtube.com/watch?v=mQyxtWrUNlE>
