# Windows Setup Guide

If the PC is running Windows, there's minimal preparation needed besides disabling Secure Boot in BIOS.

## Boot from USB

To successfully boot from USB on your laptop:

1. Insert the USB flash drive.
2. Press F9 (HP laptops) immediately before the screen lights up after restart. If you miss it, the device may not appear in the boot list. (For Lenovo laptops, use F12 or Fn + F12.)
3. Remove any other connected USB devices to avoid conflicts.

## Driver Setup

Include Wi-Fi (./wifi) and hard drive (./disk) drivers folders in a separate USB drive. These drivers, available in this repository, are essential for a successful installation, especially if they are missing after formatting the disks during a clean install.

## First steps

1. Install Updates
   1. Check for Windows regular updates, optional updates, and Microsoft Store updates.
   2. Enable "Get the latest updates as soon as they're available" and "Receive updates for other Microsoft products".
2. Change Settings
   1. Change PC name.
   2. Setup PIN.
   3. Set "If you've been away, when should Windows require you to sign in again" to Every Time.
   4. Disable unnecessary Taskbar and Start menu icons.
   5. Enable "Searching Windows - Enhanced".
   6. Disable the lower right corner of the touchpad for right-click.
   7. Remove Bluetooth icon from the taskbar.
   8. Enable Clipboard history.
   9. Enable "Show hidden files" and disable "Hide extensions for known file types" and "Hide empty drives".
   10. Set UAC to "Never Notify".
   11. Adjust mouse and touchpad pointer speed to 80%.
   12. Set Power to "Best Performance", disable Battery Saver and set "Make my device sleep after" to Never.
   13. Enable Dark mode and Night Light.
   14. Configure Multiple displays and disable "Show my taskbar on all displays".
   15. Set Windows Terminal default profile to always run as Administrator.
   16. Set Start layout to "More recommendations".
   17. Disable Lock Screen widgets.
   18. Remove other keyboard layouts.

### ... restart the PC after applying the initial configurations

## Additional Updates

1. Recheck for Updates
   - Recheck for Windows updates, optional updates, and Microsoft Store updates.
2. Uninstall Bloatware
   - Remove any pre-installed or unnecessary applications.

### ... restart the PC again

## Install General Use Apps with WinGet (Windows Package Manager)

To install essential apps quickly, open Windows Terminal and run:

```powershell
winget install Google.Chrome Google.ChromeRemoteDesktopHost Microsoft.VisualStudioCode qBittorrent.qBittorrent VideoLAN.VLC Obsidian.Obsidian -e
```

## (PREFERRED OPTION) Local Setup

First, create a code folder in your C drive to store all your projects. Open Windows Terminal and run:

```powershell
mkdir C:\code
```

To allow running scripts:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
```

To install development tools:

```powershell
winget install Git.Git Python.Python.3.12 OpenJS.NodeJS PHP.PHP.8.4 Oracle.JDK.21 -e
```

To set up Git, close and reopen Windows Terminal and run:

```powershell
git config --global user.name "rimedelis"
git config --global user.email "rimedelis@gmail.com"
```

To install Python packages:

```powershell
pip install ipykernel numpy pandas seaborn python-dotenv requests beautifulsoup4 wordcloud tqdm plotly selenium cloudscraper openpyxl
pip install python-telegram-bot webdriver-manager PyPDF2 pdfplumber tabula-py browser_cookie3 XlsxWriter
```

### ... restart the PC one more time

To install Composer, Android Studio and Flutter, visit their official websites for the latest installation instructions:

- [Composer](https://getcomposer.org/Composer-Setup.exe)
  - Before running composer install on a new repository, remove the existing vendor folder and composer.lock file to avoid potential dependency conflicts.
- [Android Studio](https://developer.android.com/studio)
  - Install Android Studio and, during setup, make sure to enable the following components in the SDK Manager:
    - Android SDK Platform-Tools
    - Android SDK Command-line Tools (latest)
    - Android Emulator

  The SDK will automatically be installed at: C:\Users\rimed\AppData\Local\Android\Sdk

- [Flutter](https://docs.flutter.dev/get-started/quick)
  - Follow the instructions to set up Flutter via VS Code and choose the root of the C drive as the installation path (i.e., C:\flutter).

Set environment variables:

```powershell
setx JAVA_HOME "C:\Program Files\Java\jdk-21" /M
setx ANDROID_HOME "C:\Users\rimed\AppData\Local\Android\Sdk" /M
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$newPath = "$currentPath;C:\Users\rimed\AppData\Local\Android\Sdk\cmdline-tools\latest\bin;C:\Users\rimed\AppData\Local\Android\Sdk\platform-tools;C:\Program Files\Java\jdk-21\bin"
setx Path $newPath /M
```

The manual installation of Android Command-line Tools are optional - only perform this step if Android Studio did not automatically install the SDK, and flutter doctor still reports: "Unable to locate Android SDK.":

- [Android Command-line Tools](https://developer.android.com/studio#command-tools)
  - Create a folder (or check if it exists) for the command-line tools:

    ```powershell
    mkdir C:\Users\rimed\AppData\Local\Android\Sdk\cmdline-tools\latest
    ```

  - Extract the downloaded zip and copy all its files and folders into C:\Users\rimed\AppData\Local\Android\Sdk\cmdline-tools\latest so that that folder contains a bin folder (C:\Users\rimed\AppData\Local\Android\Sdk\cmdline-tools\latest\bin), a lib folder, and the source.properties file.
  - Install the necessary SDK components:

    ```powershell
    cd "C:\Users\rimed\AppData\Local\Android\Sdk\cmdline-tools\latest\bin"
    .\sdkmanager.bat --licenses
    .\sdkmanager.bat "platform-tools" "platforms;android-35" "build-tools;35.0.0"
    ```

### ... and restart the PC yet again

To update the Winget apps:

```powershell
winget upgrade --all
```

## (OPTION 2) WSL Setup

1. Install WSL: Open Windows Terminal and run the following command:

   ```powershell
   wsl --install
   ```

   This will install the core WSL components.
2. Restart Your PC.
3. Install the Default Linux Distro: After the restart, open Windows Terminal and run:

   ```powershell
   wsl --install
   ```

   This will install the default Linux distribution (usually Ubuntu).
4. Restart Your PC.
5. Set Up WSL: After the restart, open Windows Terminal and run:

   ```powershell
   wsl
   ```

   During the setup, you'll be asked to create a username and password. Set the username as "rimedelis" and password as "1234".
6. Create Your Project Folder: Inside the WSL environment, manually create a code folder for your projects, or do it automatically by running:

   ```bash
   mkdir -p /home/rimedelis/code
   ```

   This will create a folder at /home/rimedelis/code, which you'll use for your project files.

   /home/rimedelis/code

Set proper ownership permissions for the /code folder, otherwise you cannot clone git repos into it:

```bash
sudo chown rimedelis: /home/rimedelis/code
```

When first opening VS Code, make sure to connect to WSL by clicking "Connect to WSL" in the bottom-left corner, and only then clone git repositories into the WSL /code folder.

## Set Up Git

Open a Ubuntu terminal (via Windows Terminal) to configure Git credentials for the entire environment:

Username and email address must be configured before Git can be used.

```bash
sudo apt install git
git config --global user.name "rimedelis"
git config --global user.email "rimedelis@gmail.com"
```

### (OPTION 2.1) Set Up Ubuntu

Instead of using Docker containers, you can install all necessary development tools directly in your Ubuntu WSL environment:

1. Update System & Install Core Tools:

   ```bash
   sudo apt update && sudo apt upgrade
   sudo apt install build-essential curl wget software-properties-common
   ```

2. Set Up Node.js 20 (recommended method):

   ```bash
   curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
   sudo apt install nodejs
   sudo npm install -g yarn
   ```

   Alternative method using snap (if preferred):

   ```bash
   sudo snap install node --classic
   ```

3. Set Up PHP & Composer:

   Add PHP repository and install PHP:

   ```bash
   sudo add-apt-repository ppa:ondrej/php
   sudo apt update
   sudo apt install php8.2-cli php8.2-common php8.2-mysql php8.2-zip php8.2-gd php8.2-mbstring php8.2-curl php8.2-xml php8.2-bcmath php8.2-intl

   sudo apt install composer
   ```

   When first installing the backend PHP dependencies on a repository, always remove the vendor folder and composer.lock file before running composer install, otherwise errors may occur:

   ```bash
   rm -rf vendor composer.lock
   composer install
   ```

4. Set Up Python Environment:

   Install pip and dev headers, then install Python packages available in repositories, and then install Python packages NOT available in repositories:

   ```bash
   sudo apt install python3-pip python3-dev

   sudo apt install python3-ipykernel python3-numpy python3-pandas python3-seaborn python3-dotenv python3-requests python3-bs4 python3-wordcloud python3-tqdm python3-plotly python3-selenium python3-cloudscraper python3-openpyxl

   pip3 install --break-system-packages python-telegram-bot webdriver-manager PyPDF2 pdfplumber tabula-py browser_cookie3 XlsxWriter
   ```

   Alternative: Create and use a virtual environment

   ```bash
   python3 -m venv ~/venvs/myproject
   source ~/venvs/myproject/bin/activate
   pip install python-dotenv python-telegram-bot requests beautifulsoup4
   ```

5. Flutter Development Setup:

   Install Flutter SDK, OpenJDK 21, and ADB/Fastboot tools:

   ```bash
   sudo snap install flutter --classic

   sudo apt install openjdk-21-jdk

   sudo apt install adb fastboot
   ```

6. Android SDK Setup:

   Create directories, download/extract tools (URL changes with each new version - replace "13114758" with the correct release number), move to the expected structure, set environment variables, and install required SDK components:

   ```bash
   mkdir -p ~/Android/Sdk/cmdline-tools
   cd ~/Android/Sdk/cmdline-tools

   wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip

   unzip commandlinetools-linux-13114758_latest.zip

   mv cmdline-tools latest

   echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
   echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools' >> ~/.bashrc
   source ~/.bashrc

   sdkmanager --licenses
   sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"
   ```

7. Connect Android Device to WSL2:

   #### Step 1: Enable Wireless Debugging on Android Device

   - Go to Settings -> About Phone.
   - Tap Build Number 7 times to enable Developer Options.
   - Go to Settings -> Developer Options.
   - Enable Wireless Debugging.
   - Tap on Wireless Debugging to see pairing options.

   #### Step 2: Restart ADB Server (use a Ubuntu terminal for the following steps)

   ```bash
   adb kill-server
   adb start-server
   ```

   #### Step 3: Pair with Android Device

   1. On your Android phone:
      - Select "Pair device with pairing code".
      - Note both the pairing code (e.g., 941735) and the pairing port (e.g., 35703).
   2. In the terminal:

      Use the PAIRING port shown on your phone. When prompted, enter the pairing code shown on your phone.

      ```bash
      adb pair 192.168.1.64:35703
      ```

   #### Step 4: Connect to the Device

   Use the DEBUGGING port shown on your phone (different from pairing port).

   ```bash
   adb connect 192.168.1.64:42573
   ```

   #### Step 5: Verify Connection

   Verify ADB sees the device, then check if Flutter recognizes the device. It should show something like "List of devices attached" and "192.168.1.64:42573      device".

   ```bash
   adb devices

   flutter devices
   ```

   #### Step 6: Running Your Flutter App

   Navigate to your project and run the app on your Android device.

   ```bash
   cd ~/code/onboard-mobile

   flutter run

   # or specify the device if you have multiple devices connected

   flutter run -d 192.168.1.64:42573
   ```

8. Install LAMP Stack (if you need a local web server):

   Install Apache, MySQL, and PHP with Apache module, then start and enable services:

   ```bash
   sudo apt install apache2 mysql-server libapache2-mod-php

   sudo systemctl start apache2
   sudo systemctl enable apache2
   sudo systemctl start mysql
   sudo systemctl enable mysql
   ```

### (OPTION 2.2) Set Up Docker

1. Sign In: Open Docker Desktop and sign in. Once signed in, all Docker components will be configured and ready to use.
2. Add docker-compose.yml File: Paste the docker-compose.yml file (from this repository) into the code folder located at:
3. Spin Up Containers: Open the terminal in your code folder and run:

   This command builds and runs your containers in detached mode.

   ```bash
   docker-compose up -d --build
   ```

4. Access Specific Containers: Depending on your project requirements, enter the appropriate container to run necessary commands.

   Node Projects:

   ```bash
   docker exec -it node-container bash
   ```

   After entering the container, navigate to your project folder before running commands. For example:

   ```bash
   cd /code/my-repo-name/
   npm run dev
   ```

   Composer (PHP) Projects:

   ```bash
   docker exec -it composer-container bash
   ```

   Python Projects:

   ```bash
   docker exec -it python-container bash
   ```

5. Run Your Commands: Once inside the chosen container and in the correct project directory, execute any additional commands you need (e.g., running npm run dev for Node, composer up for PHP projects, or your specific Python commands).

### ... restart the PC one last time

## Final steps

1. Change Settings
   - Disable all "Startup apps".
   - Change "Default apps".
   - Check "Cleanup recommendations".
   - Check "Defragment and optimize your drives".

## Extra tips

- You can either manually go through the previous list or use [Wintoys](https://apps.microsoft.com/detail/9p8ltpgcbzxd?hl=en-US&gl=US) for a quicker setup.
- Windows God Mode: Create a folder called "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" that gives us all hidden Windows settings.
