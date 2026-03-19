# Ubuntu Setup Guide

## BIOS and USB Boot Notes

If the PC is running Windows, it's mandatory to disable "Secure Boot" and recommended to disable "Fast Boot" in BIOS.

To be able to boot successfully from USB on my HP laptop, the trick is to simultaneously insert the USB flash drive and press F9, right before the screen first lights up after restart, or else the device won't appear on the boot list. On Lenovo laptops, restart the PC and press F12 (Fn+F12). I also find it best to remove any other USB devices connected to the laptop.

Flashing a Linux image typically involves using [Rufus (Portable)](https://rufus.ie/) to create a bootable USB drive or SD card with the Linux distribution's installation files. Once the image is flashed onto the drive, it becomes formatted in a filesystem format that may not be natively supported by Windows or macOS.

Windows typically uses NTFS or FAT32 filesystems, while macOS uses HFS+ or APFS. Linux distributions often use filesystems like ext4.

Here's how to fix this: [https://blog.balena.io/did-etcher-break-my-usb-sd-card/](https://blog.balena.io/did-etcher-break-my-usb-sd-card/)

## Initial System Update and Settings

### Check for updates and change system settings

apt stands for Advanced Package Tool. In truth, apt doesn't need to be preceded by sudo as it automatically performs operations with superuser privileges when necessary, but it's still standard to type it, to guarantee that the commands run successfully in all situations.

Check for updates:

```bash
sudo apt update && sudo apt upgrade
```

Dock and Desktop settings:

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
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

# Hide "Home" folder icon on desktop
gsettings set org.gnome.shell.extensions.ding show-home false
```

Mouse and Touchpad settings:

```bash
# Increase mouse pointer speed
gsettings set org.gnome.desktop.peripherals.mouse speed 1.0

# Set touchpad speed
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.75

# Set "Secondary Click" to "Two Finger Push"
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'

# Enable "Tap to Click"
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```

Power settings:

```bash
# Disable "Dim Screen"
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

# Set "Screen Blank" to "3 minutes"
gsettings set org.gnome.desktop.session idle-delay 180

# Enable "Show battery percentage"
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Disable "Automatic Suspend"
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# Set "Power Button Behavior" to "Suspend"
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
```

Remember Num Lock state:

```bash
gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
```

Show hidden files:

```bash
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden true
```

Enable location services:

```bash
gsettings set org.gnome.system.location enabled true
```

Enable Night Light and Dark Style:

```bash
# Enable "Night Light" and set it to "Sunset to Sunrise"
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

# Enable "Dark Style"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

---

### Restart the computer for changes to apply

```bash
sudo reboot now
```

---

### Change Software & Updates settings

Use the Super Key to open the Activities overview and search for "Software & Updates":

- Under "Updates", set "When there are other updates" to "Display immediately".

## Packages to install

- In recent versions of Ubuntu, the Snap package manager (snapd) is preinstalled by default -- it's the new App Center (orange icon), featuring only Debian and Snap apps from the Snapcraft store. As a rule, prefer "apt" whenever available.
- For example, sudo apt install package-name installs the package version available in the Ubuntu repositories managed by APT (Advanced Package Tool). This version may be different from the version available as a snap package from the Snap Store, installable running the command sudo snap install package-name.
- To manually fetch the latest versions of installed snaps from the Snap Store and update them: sudo snap refresh.

### Google Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

If this notice appears, ignore it, as the program was anyway installed correctly:

Notice: Download is performed unsandboxed as root as file '/home/rimedelis/google-chrome-stable_current_amd64.deb' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)

### Git

Username and email address must be configured before Git can be used.

```bash
sudo apt install git
git config --global user.name "rimedelis"
git config --global user.email "rimedelis@gmail.com"
```

### Visual Studio Code

Format Document (Ctrl+Shift+I) - Format the entire active file.

Install dependencies:

```bash
sudo apt install curl gpg apt-transport-https
```

Import the Microsoft GPG key (dearmored to keyring):

```bash
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | \
  gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
```

Add the Microsoft VS Code repository:

```bash
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | \
  sudo tee /etc/apt/sources.list.d/vscode.list
```

Install VS Code:

```bash
sudo apt update
sudo apt install code
```

Create a folder for all the code projects:

```bash
mkdir -p /home/rimedelis/code
```

### Diodon

```bash
sudo add-apt-repository ppa:diodon-team/stable
sudo apt update
sudo apt install diodon
```

Under "Keyboard", set a Custom Shortcut for Diodon (command is "/usr/bin/diodon" and shortcut is Super + V).

### Node.js

Add NodeSource repository (for Node.js 20 LTS), then install Node.js and npm:

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs
```

### PHP

```bash
sudo apt install php php-cli php-mbstring php-xml php-curl php-zip
```

### Composer

Download Composer installer:

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
```

Verify installer integrity:

```bash
php -r "if (hash_file('sha384', 'composer-setup.php') === 'ed0feb545ba87161262f2d45a633e34f591ebb3381f2e0063c345ebea4d228dd0043083717770234ec00c5a9f9593792') { echo 'Installer verified\\n'; } else { echo 'Installer corrupt\\n'; unlink('composer-setup.php'); exit(1); }"
```

Install Composer system-wide:

```bash
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
```

Clean up:

```bash
php -r "unlink('composer-setup.php');"
```

When first installing the backend PHP dependencies on a repository, always remove the vendor folder and composer.lock file before running composer install, otherwise errors may occur:

```bash
rm -rf vendor composer.lock
composer install
```

### Python Development Environment

Install pip and Python development headers:

```bash
sudo apt install python3-pip python3-dev
```

Install Python packages available in Ubuntu repositories:

```bash
sudo apt install python3-ipykernel python3-numpy python3-pandas python3-seaborn python3-dotenv python3-requests python3-bs4 python3-wordcloud python3-tqdm python3-plotly python3-selenium python3-cloudscraper python3-openpyxl
```

Install Python packages NOT available in repositories (system-wide):

```bash
sudo pip3 install --break-system-packages python-telegram-bot webdriver-manager PyPDF2 pdfplumber tabula-py browser_cookie3 XlsxWriter
```

### OpenJDK 21 -- Java Development Kit

```bash
sudo apt install openjdk-21-jdk
```

### Flutter

```bash
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev libstdc++-12-dev mesa-utils
cd ~
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.35.7-stable.tar.xz
tar xf flutter_linux_3.35.7-stable.tar.xz
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
flutter doctor -v
```

### Android Studio

```bash
cd ~/Downloads
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2025.1.4.8/android-studio-2025.1.4.8-linux.tar.gz
sudo tar -xzf android-studio-2025.1.4.8-linux.tar.gz -C /opt/
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
/opt/android-studio/bin/studio.sh
```

After launching Android Studio, complete the setup wizard and ensure the following SDK components are installed via SDK Manager:

- Android SDK Platform-Tools
- Android SDK Command-line Tools (latest)
- Android Emulator

The SDK will be automatically installed at: ~/Android/Sdk

Enable KVM for Android Emulator hardware acceleration (recommended for acceptable emulator performance):

```bash
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo adduser $USER kvm
```

Set environment variables:

```bash
echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64' >> ~/.bashrc
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator' >> ~/.bashrc
source ~/.bashrc
flutter doctor
flutter doctor --android-licenses
```

### Manual Android Command-line Tools installation

Only if Android Studio didn't install SDK and flutter doctor reports "Unable to locate Android SDK".

Create directories for Android SDK:

```bash
mkdir -p ~/Android/Sdk/cmdline-tools/latest
cd ~/Android/Sdk/cmdline-tools/latest
```

Download Android Command Line Tools (URL changes with each new version - replace "13114758" with the correct release number. For more information, visit: <https://developer.android.com/studio>):

```bash
wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
```

Extract the zip file:

```bash
unzip commandlinetools-linux-13114758_latest.zip
```

Move to the expected directory structure (required by Flutter):

```bash
mv cmdline-tools/* .
rm -r commandlinetools-linux-13114758_latest.zip cmdline-tools
```

Install required SDK components:

```bash
sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
yes | sdkmanager --licenses
```

#### Connecting Android Device to Ubuntu Wirelessly

##### Step 1: Enable Wireless Debugging on Android Device

- Go to Settings -> About Phone
- Tap Build Number 7 times to enable Developer Options
- Go to Settings -> Developer Options
- Enable Wireless Debugging
- Tap on Wireless Debugging to see pairing options

##### Step 2: Restart ADB Server (use a Ubuntu terminal for the following steps)

```bash
adb kill-server
adb start-server
```

##### Step 3: Pair with Android Device

1. On your Android phone:

   - Select "Pair device with pairing code"
   - Note both the pairing code (e.g., 941735) and the pairing port (e.g., 35703)
  
2. In the terminal:

  Use the PAIRING port shown on your phone. When prompted, enter the pairing code shown on your phone.

  ```bash
  adb pair 192.168.1.64:35703
  ```

##### Step 4: Connect to the Device

Use the DEBUGGING port shown on your phone (different from pairing port).

```bash
adb connect 192.168.1.64:42573
```

##### Step 5: Verify Connection

Verify ADB sees the device, then check if Flutter recognizes the device. It should show something like:

- List of devices attached
- 192.168.1.64:42573      device

```bash
adb devices
flutter devices
```

##### Step 6: Running Your Flutter App

Navigate to your project and run the app on your Android device:

```bash
cd ~/code/onboard-mobile
flutter run

# or specify the device if you have multiple devices connected

flutter run -d 192.168.1.64:42573
```

## Packages to uninstall

Open "App Center" and uninstall:

Update all installed Snap packages:

```bash
sudo snap refresh
```

Uninstall Firefox:

```bash
sudo snap remove firefox
```

## Clean up afterwards

To remove the packages that failed to install completely:

```bash
sudo apt autoclean
```

Additionally, to remove the apt-cache:

```bash
sudo apt clean
```

Finally, to remove the unwanted software dependencies:

```bash
sudo apt autoremove
```

---

### Restart the computer again for changes to apply

```bash
sudo reboot now
```

---

### Change Default Applications

Under "Settings", set the Default Applications.

### Disable Startup Applications

Under "Startup Application Preferences", disable or remove the programs.

## Optional packages and extras

### VLC

```bash
sudo apt install vlc
```

### qBittorrent

```bash
sudo apt install qbittorrent
```

### LAMP Stack (if you need a local web server)

Install Apache, MySQL, and PHP with Apache module:

```bash
sudo apt install apache2 mysql-server libapache2-mod-php
```

Start and enable services:

```bash
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mysql
sudo systemctl enable mysql
```

### Docker Engine

Add Docker's official GPG key:

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Add the repository to Apt sources:

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Alternatively, install Docker using Snap:

```bash
sudo snap install docker
```

#### Set Up Docker

1. If you haven't already, create a folder for your projects:

  ```bash
  mkdir -p /home/rimedelis/code
  ```

  This will create a folder at /home/rimedelis/code, which you'll use for your project files.
2. Add [[docker-compose.yml]] File: Paste the docker-compose.yml file (from this repository) into the code folder located at:

  /home/rimedelis/code
3. Spin Up Containers: Open the terminal in your code folder and run:

  This command builds and runs your containers in detached mode.

  ```bash
  sudo docker-compose up -d --build
  ```

4. Access Specific Containers: Depending on your project requirements, enter the appropriate container to run necessary commands:

  Node Projects:

  ```bash
  sudo docker exec -it node-container bash
  ```

  After entering the container, navigate to your project folder before running commands. For example:

  ```bash
  cd /code/my-repo-name/
  npm run dev
  ```

  Composer (PHP) Projects:

  ```bash
  sudo docker exec -it composer-container bash
  ```

  Python Projects:

  ```bash
  sudo docker exec -it python-container bash
  ```

5. Run Your Commands: Once inside the chosen container and in the correct project directory, execute any additional commands you need (e.g., running npm run dev for Node, composer up for PHP projects, or your specific Python commands).

### Flatpak

Flatpak adds the Software app (white icon, a shopping bag with 3 colorful geometric shapes) to the system. The only downside is that you'll see multiple applications in Ubuntu software center. Flatpak applications are tagged with source dl.flathub.org and thus you can easily distinguish them.

Note: Snaps are more tightly integrated with Ubuntu specifically, whereas Flatpaks are developed for several Linux distros. However, both systems utilize sandboxing to isolate applications from the rest of the system. Their self-containment means that they can run independently of the system's installed libraries, reducing dependency issues and conflicts.

Reference: <https://flatpak.org/setup/Ubuntu>

```bash
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
```

Adds the Flathub repository. Flathub is the best place to get Flatpak apps:

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

### Thonny

Unofficial snap:

```bash
sudo snap install thonny
```

However, for my use case, I installed version 4.0.1, .deb package from the Software app (Flatpak/Flathub related app) because snap didn't let me install packages on Raspberry, didn't recognize the existence of the Raspberry.

#### In Thonny, to allow the Raspberry to run

```bash
sudo usermod -a -G dialout <username>
```

### Microsoft Edge -- web browser

For most recent version, visit this page and then edit the link in the command below: [https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/](https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/)

```bash
cd ~/Downloads
wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_122.0.2365.92-1_amd64.deb
sudo apt install ./microsoft-edge-stable_122.0.2365.92-1_amd64.deb
```

### TLP -- command line utility for Linux (Battery Optimization)

```bash
sudo apt install tlp
sudo tlp start
```

To make any customizations to TLP's settings, you can edit the configuration file (/etc/default/tlp) and then reload TLP with ```sudo tlp start``` to apply the changes.

Note: Installing TLP will remove the default power-profiles-daemon package. This means you'll no longer be able to switch power modes (Power Saver, Balanced, Performance) from the system settings UI.

### ubuntu-restricted-extras

Includes various multimedia codecs and libraries that enable support for MP3, DVD playback, Adobe Flash, Microsoft fonts, and some video codecs that aren't included by default due to licensing restrictions.

```bash
sudo apt install ubuntu-restricted-extras
```

## Tips and tricks

### To make Anaconda work

```bash
sudo apt-get install libgl1+libglx-mesa0 libegl1 libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
libgl1+libglx-mesa0 libegl1
```

### Prevent a Package From Being Updated in Ubuntu

[How to prevent a package from being updated in Ubuntu](https://itsfoss.com/prevent-package-update-ubuntu/)

This can be done using Aptitude.

#### Aptitude

To hold a package and thus prevent apt from making changes to it:

```bash
sudo apt-mark hold package_name
```

To list all the packages that are held:

```bash
sudo apt-mark showhold
```

To remove hold on a package:

```bash
sudo apt-mark unhold package_name
```

### To take screenshots

PrintScreen: Opens the screenshot taking tool.

Alt+PrintScreen: Takes a screenshot of the active window.

Shift+PrintScreen: Takes a screenshot of the entire screen (multiple displays).

## Uninstalling Ubuntu

To uninstall Ubuntu and delete dual boot in Windows: [https://www.youtube.com/watch?v=mQyxtWrUNlE](https://www.youtube.com/watch?v=mQyxtWrUNlE)
