# Debian 13 (Trixie) Setup Guide

## BIOS and USB Boot Notes

If the PC is running Windows, disable Secure Boot and preferably disable Fast Boot in BIOS.

To boot from USB on an HP laptop, insert the USB flash drive and press F9 just before the screen lights up after restart, or the device may not appear in the boot list. On Lenovo laptops, restart and press F12 (Fn+F12). It also helps to remove other USB devices connected to the laptop.

Flashing a Linux image typically involves using [Rufus (Portable)](https://rufus.ie/) to create a bootable USB drive or SD card with the Linux distribution installation files.

If the USB drive looks broken after flashing Linux, use this recovery guide:
[https://blog.balena.io/did-etcher-break-my-usb-sd-card/](https://blog.balena.io/did-etcher-break-my-usb-sd-card/)

## Initial System Update and Settings

### Configure Debian 13 repositories first

Edit sources list:

```bash
sudo tee /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
EOF
```

### Check for updates and install base firmware/codecs

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y curl wget ca-certificates gnupg
sudo apt full-upgrade -y
sudo apt install -y firmware-linux-nonfree libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly
sudo apt install -y ffmpegthumbs kio-extras
sudo apt install -y build-essential
sudo apt install -y ttf-mscorefonts-installer
sudo apt install -y intel-microcode
```

### KDE Plasma settings (your current desktop)

```bash
# Enable Dark Theme (Tema Escuro)
lookandfeeltool -a org.kde.breezedark.desktop

# Mouse Speed (Value from -1.0 to 1.0)
kwriteconfig6 --file kcminputrc --group "Libinput" --group "Mouse" --key "PointerSensitivity" 0.6

kwriteconfig6 --file kcminputrc --group "Libinput" --group "Mouse" --key "AccelerationProfile" 0

kwriteconfig6 --file kcminputrc --group "Libinput" --group "Touchpad" --key "PointerSensitivity" 0.6

# Tap to Click (Ativar o clique com toque leve)
kwriteconfig6 --file kcminputrc --group "Libinput" --group "Touchpad" --key "TapToClick" true

# Inverter a direção do scroll (Scroll Natural - true ou false)
kwriteconfig6 --file kcminputrc --group "Libinput" --group "Touchpad" --key "NaturalScroll" false

# Show battery percentage (on the battery icon)
kwriteconfig6 --file plasmanotifierrc --group "SystemsSettings" --key "ShowBatteryPercentage" true

# Enable Num Lock on KDE startup
kwriteconfig6 --file kcminputrc --group Keyboard --key NumLock 2
# (Note: 0 = Enable, 1 = Disable, 2 = Leave as is on startup)

# Apply interface changes without restarting the session (in some cases)
qdbus6 org.kde.KWin /KWin reconfigure
plasmashell --replace & disown
```

### Restart the computer for changes to apply

```bash
sudo reboot now
```

### KDE app center and updates behavior

On Debian KDE, use Discover.

Install Flatpak integration in Discover:

```bash
sudo apt install -y flatpak plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Flatseal to manage Flatpak permissions (Folders, USB, etc.)
flatpak install -y flathub com.github.tchx84.Flatseal
```

## Packages to install

- On Debian, prefer apt whenever available.
- Snap is not always preinstalled on Debian. Install it only if you need Snap packages.
- Avoid Ubuntu PPAs on Debian. Use Debian repos, official vendor repos, or Flatpak.

### Google Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
```

If this notice appears, it is usually harmless:

Notice: Download is performed unsandboxed as root as file '/home/rimedelis/google-chrome-stable_current_amd64.deb' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)

### Git

Username and email address must be configured before Git can be used.

```bash
sudo apt install -y git
git config --global user.name "rimedelis"
git config --global user.email "rimedelis@gmail.com"
```

### Visual Studio Code

Import Microsoft key and add repository:

```bash
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo apt update
sudo apt install -y code
```

Create a folder for all code projects:

```bash
mkdir -p "$HOME/code"
```

### Node.js

Use current LTS setup script:

```bash
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt install -y nodejs
```

### PHP

```bash
sudo apt install -y php php-cli php-mbstring php-xml php-curl php-zip
```

### Composer

Download installer:

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
ACTUAL_SIGNATURE=$(php -r "echo hash_file('sha384', 'composer-setup.php');")
if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then echo Installer corrupt; rm composer-setup.php; exit 1; fi

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

php -r "unlink('composer-setup.php');"
```

When first installing backend PHP dependencies on a repository:

```bash
rm -rf vendor composer.lock
composer install
```

### Python Development Environment

#### 1. System Libraries

Install base headers and the virtual environment tool:

```bash
sudo apt install -y python3-pip python3-dev python3-venv

# Install heavy/stable packages from Debian repositories (Global):

sudo apt install -y python3-ipykernel python3-numpy python3-pandas python3-seaborn python3-dotenv python3-requests python3-bs4 python3-wordcloud python3-tqdm python3-plotly python3-selenium python3-openpyxl
```

#### 2. Hybrid Virtual Environment (The "Tools" Venv)

Create a venv that can "see" the system packages (numpy, pandas) but allows installing extras like cloudscraper.

```bash
# 1. Criar a pasta para os venvs
mkdir -p "$HOME/.local/venvs"
# The --system-site-packages flag is the secret to link Debian packages with Pip packages
python3 -m venv --system-site-packages "$HOME/.local/venvs/tools"

# Install extras not available in Debian repos
"$HOME/.local/venvs/tools/bin/pip" install --upgrade pip
"$HOME/.local/venvs/tools/bin/pip" install cloudscraper python-telegram-bot webdriver-manager PyPDF2 pdfplumber tabula-py browser_cookie3 XlsxWriter
```

How to run Python scripts with the virtual environment:

```bash
source ~/.local/venvs/tools/bin/activate
python meu_script.py
# Quando terminares:
deactivate
```

OR

#### 3. Visual Studio Code Integration (UI Setup)

To make VS Code recognize all libraries (System + Venv) automatically:

- Open your project in VS Code.

- Press Ctrl + Shift + P and search for "Python: Select Interpreter".

- Choose "Enter interpreter path..." -> "Find...".

- Navigate to your venv folder: ~/.local/venvs/tools/bin/python (or /home/$USER/.local/venvs/tools/bin/python).

- Result: VS Code will now run your scripts using the "Play" button with full support for both Pandas (System) and Cloudscraper (Venv).

### OpenJDK 21 -- Java Development Kit

```bash
sudo apt install -y openjdk-21-jdk
```

### Flutter

```bash
sudo apt update -y
sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev libstdc++-12-dev mesa-utils xz-utils unzip libvulkan1

cd ~
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.41.5-stable.tar.xz
tar xf flutter_linux_3.41.5-stable.tar.xz
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
flutter doctor -v
```

<https://docs.flutter.dev/install/archive#stable-channel>
If the version above is outdated when you run this, replace with the current stable tarball from the official page: <https://docs.flutter.dev/install/archive#stable-channel>

### Android Studio

```bash
cd ~/Downloads
wget https://edgedl.me.gvt1.com/android/studio/ide-zips/2025.3.2.6/android-studio-panda2-linux.tar.gz
sudo tar -xzf android-studio-panda2-linux.tar.gz -C /opt/
sudo apt install -y libc6:i386 libncurses6:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
/opt/android-studio/bin/studio.sh
```

If that exact build is no longer available, use the latest filename from the official website: <https://developer.android.com/studio>

After launching Android Studio, complete setup and ensure SDK components are installed:

- Android SDK Platform-Tools
- Android SDK Command-line Tools (latest)
- Android Emulator

The SDK is typically installed at: ~/Android/Sdk

Enable KVM hardware acceleration:

```bash
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
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

Only if Android Studio did not install SDK and flutter doctor reports Unable to locate Android SDK.

Create directories:

```bash
mkdir -p ~/Android/Sdk/cmdline-tools/latest
cd ~/Android/Sdk/cmdline-tools/latest
```

Download Android Command Line Tools from:

<https://developer.android.com/studio>

Example:

```bash
wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
```

Extract:

```bash
unzip commandlinetools-linux-13114758_latest.zip
```

Move to expected structure:

```bash
mv cmdline-tools/* .
rm -r commandlinetools-linux-13114758_latest.zip cmdline-tools
```

Install required SDK components:

```bash
sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
yes | sdkmanager --licenses
```

#### Connecting Android Device to Debian Wirelessly

##### Step 1: Enable Wireless Debugging on Android device

- Go to Settings -> About Phone
- Tap Build Number 7 times to enable Developer Options
- Go to Settings -> Developer Options
- Enable Wireless Debugging
- Tap Wireless Debugging to see pairing options

##### Step 2: Restart ADB server

```bash
adb kill-server
adb start-server
```

##### Step 3: Pair with Android device

On your Android phone: Select "Pair device with pairing code". Note both the pairing code (e.g., 941735) and the pairing port (e.g., 35703)

Use the pairing port shown on your phone:

```bash
adb pair 192.168.1.64:35703
```

##### Step 4: Connect to the device

Use the debugging port shown on your phone:

```bash
adb connect 192.168.1.64:42573
```

##### Step 5: Verify connection

```bash
adb devices
flutter devices
```

##### Step 6: Run your Flutter app

```bash
cd ~/code/onboard-mobile
flutter run

# or specify the device if you have multiple devices connected

flutter run -d 192.168.1.64:42573
```

### Change Default Applications

On KDE: System Settings -> Applications -> Default Applications.

### Disable Startup Applications

On KDE: System Settings -> Session -> Autostart.

## Optional packages and extras

### VLC

```bash
sudo apt install -y vlc
```

### qBittorrent

```bash
sudo apt install -y qbittorrent
```

### LAMP Stack (if you need a local web server)

Install Apache, MySQL, and PHP with Apache module:

```bash
sudo apt install -y apache2 mysql-server libapache2-mod-php
```

Start and enable services:

```bash
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mysql
sudo systemctl enable mysql
```

### Docker Engine

Add Docker official GPG key for Debian:

```bash
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Add repository to apt sources:

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

#### Set Up Docker

1. Add docker-compose.yml file from this repository into your code folder.

2. Spin up containers in detached mode:

   ```bash
   sudo docker compose up -d --build
   ```

   If your environment still uses legacy binary, this also works:

   ```bash
   sudo docker-compose up -d --build
   ```

3. Access specific containers:

   Node projects:

   ```bash
   sudo docker exec -it node-container bash
   cd /code/my-repo-name/
   npm run dev
   ```

   Composer (PHP) projects:

   ```bash
   sudo docker exec -it composer-container bash
   ```

   Python projects:

   ```bash
   sudo docker exec -it python-container bash
   ```

4. Run project-specific commands inside the chosen container.

### Thonny

```bash
flatpak install -y flathub org.thonny.Thonny
```

### Microsoft Edge -- web browser

For the latest version, check:

<https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/>

Then install downloaded package:

```bash
cd ~/Downloads
sudo apt install -y ./microsoft-edge-stable_*_amd64.deb
```

### TLP -- command line utility for Linux battery optimization

```bash
sudo apt install -y tlp
sudo tlp start
```

You can customize settings in /etc/default/tlp and reload with sudo tlp start.

### ZRAM (Performance Boost)

```bash
sudo apt install -y zram-tools
# It configures itself automatically upon installation.
```

## Final Permissions and Groups

```bash
# Ensure you can use Docker, Emulator and Serial without sudo
sudo usermod -aG docker,kvm,libvirt,dialout,plugdev,video $USER
```

## Packages to uninstall

On Debian KDE, Firefox usually comes as firefox-esr package. Remove only if you want another channel:

```bash
sudo apt remove -y firefox-esr
```

## Clean up afterwards

To remove partially installed package data:

```bash
sudo apt autoclean
```

Remove apt cache:

```bash
sudo apt clean
```

Remove unused dependencies:

```bash
sudo apt autoremove -y
```

### Restart the computer again for changes to apply

```bash
sudo reboot now
```

## Tips and tricks

### To make Anaconda work

```bash
sudo apt install -y libgl1 libglx-mesa0 libegl1 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
```

### Prevent a package from being updated in Debian

You can use apt-mark:

```bash
sudo apt-mark hold package_name
```

List all held packages:

```bash
sudo apt-mark showhold
```

Remove hold from a package:

```bash
sudo apt-mark unhold package_name
```

### To take screenshots in KDE

PrintScreen opens the screenshot tool.

Alt+PrintScreen captures the active window.

Shift+PrintScreen captures the entire screen.

## Uninstalling Debian

If this machine is dual boot and you later want to remove Debian from Windows:

[https://www.youtube.com/watch?v=mQyxtWrUNlE](https://www.youtube.com/watch?v=mQyxtWrUNlE)
