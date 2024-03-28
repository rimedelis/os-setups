# Clean Install -- Windows 11

If the PC is running Windows, there's not much prework to be done except disabling "Secure Boot" in BIOS

To be able to boot successfully from USB on my laptop, the trick is to simultaneouly insert the USB flash drive and press F9, right before the screen first lights up after restart, or else the device won't appear on the boot list. I also find it best to remove any other USB devices connected to the laptop.

Include hard drive drivers in a folder inside the bootable USB containing the Windows ISO in order to be able to proceed with the installation successfully. Because those drivers seem to be absent after I format the disks during the clean installation process, and thus they need to be fetched manually.

---

You can go through this list and change things manually or start off using [Wintoys](https://apps.microsoft.com/detail/9p8ltpgcbzxd?hl=en-US&gl=US) which makes the process a bit quicker.

## Check for Windows regular and optional updates, as well as updates for apps from Microsoft Store

## ! Restart the computer for changes to apply !

## Setup PIN

## Change computer name

## Check for Cleanup recommendations

## Disable all notifications

## Disable taskbar and Start menu icons

## Check for driver updates via the Device Manager

## Change privacy settings: General and Diagnostics

## Disable Windows services: telemetry, print spooler, or geolocation

## Enable Clipboard history

## Enable "Show hidden files" and "Display file extension"

## Set User Account Control (UAC) to "Never Notify"

## Set Power to "Best Performance" while plugged in and "Battery Saver" otherwise

## Enable "Dark Mode"

## ! Restart the computer for changes to apply !

## Uninstall unnecessary pre-installed apps

## Disable unnecessary startup apps

## "Turn Windows features off"

## ! Restart the computer for changes to apply !

## Install apps

- Google Chrome

- VS Code

- Git

- Node.js

- qBittorrent

## Change default apps

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
```

#### Other apps I've installed with Chocolatey

```powershell
choco install sonicpi -y
choco install vmware-workstation-player -y
choco install ngrok -y
choco install gramps -y
choco install thonny -y
choco install mingw -y
choco install microsoft-windows-terminal -y
choco install msys2 -y # important for Ruby gem installations to work correctly
choco install anaconda3 -y
choco install python -y
choco install ruby -y
choco install wsl2 --params "/Version:2 /Retry:true" -y
```

## ! Restart the computer for changes to apply !

## Empty Recycle Bin and Shadow copies, and defrag the disk

## Extra tips

- Windows God Mode: Create a folder called "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" that gives us all hidden Windows settings
