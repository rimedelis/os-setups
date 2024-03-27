# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Enable global confirmation for Chocolatey
choco feature enable -n=allowGlobalConfirmation

# Programs to install with Chocolatey
choco install git -y
choco install googlechrome -y
choco install nodejs.install -y
choco install qbittorrent -y
choco install vscode -y


# Other programs I've installed with Chocolatey
# choco install sonicpi -y
# choco install vmware-workstation-player -y
# choco install ngrok -y
# choco install gramps -y
# choco install thonny -y
# choco install wsl2 --params "/Version:2 /Retry:true" -y
# choco install ruby -y
# choco install python -y
# choco install msys2 -y
# choco install mingw -y
# choco install anaconda3 -y
# choco install microsoft-windows-terminal -y
