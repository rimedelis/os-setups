# Clean Install -- Windows 11

If the PC is running Windows, there's not much prework to be done except disabling "Secure Boot" in BIOS

To be able to boot successfully from USB on my laptop, the trick is to simultaneouly insert the USB flash drive and press F9, right before the screen first lights up after restart, or else the device won't appear on the boot list. I also find it best to remove any other USB devices connected to the laptop.

Include hard drive drivers in a folder inside the bootable USB containing the Windows ISO in order to be able to proceed with the installation successfully. Because those drivers seem to be absent after I format the disks during the clean installation process, and thus they need to be fetched manually.

---

You can go through the following list and change things manually or start off using [Wintoys](https://apps.microsoft.com/detail/9p8ltpgcbzxd?hl=en-US&gl=US) which makes the process a bit quicker.

---

- Check for Windows regular and optional updates, and Microsoft Store updates

### Restart the PC

- Setup PIN

- Change PC name

- Disable Taskbar and Start menu icons

- Change privacy settings: General and Diagnostics

- Enable Clipboard history

- Enable "Show hidden files" and disable "Hide extensions for known file types" and "Hide empty drives"

- Set UAC settings to "Never Notify"

- Change mouse and touchpad pointer speed

- Set Power to "Best Performance" while plugged in and "Battery Saver" otherwise

- Disable "Hibernate" and enable "Fast Startup"

- Enable "Dark" mode

- Setup "Multiple displays" and enable "HDR" (if available)

- Change "Sound settings" to improve input/output quality

### Restart the PC

- Uninstall bloatware and unnecessary pre-installed apps

- Disable unnecessary "Startup Apps"

### Restart the PC

## Install apps

- Google Chrome

- VS Code

- Git

- Node.js

- Bruno

- Windows Terminal

- Android Studio

## Optional apps

- qBittorrent

### Installing with Chocolatey

Tip: execute `windows-chocolatey.sh` to automate the following steps.

#### First, install Chocolatey

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

#### Use this to never be asked for permission to run (always Yes to prompts)

```powershell
choco feature enable -n=allowGlobalConfirmation

# To disable global confirmation for Chocolatey
choco feature disable -n=allowGlobalConfirmation
```

#### Apps to install

```powershell
choco install git -y
choco install googlechrome -y
choco install nodejs.install -y
choco install qbittorrent -y
choco install vscode -y
choco install bruno -y
choco install docker -y
choco install microsoft-windows-terminal -y
choco install wsl2 --params "/Version:2 /Retry:true" -y
```

#### Other apps I've installed with Chocolatey

```powershell
choco install sonicpi -y
choco install vmware-workstation-player -y
choco install ngrok -y
choco install gramps -y
choco install thonny -y
choco install mingw -y
choco install msys2 -y # important for Ruby gem installations to work correctly
choco install anaconda3 -y
choco install python -y
choco install ruby -y
```

### Restart the PC

- Change "Default apps"

- Check "Disk Cleanup" and "Disk cleanup recommendations"

- Check "Defragment and Optimize Drives"

## Extra tips

- Windows God Mode: Create a folder called "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" that gives us all hidden Windows settings
