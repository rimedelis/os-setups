# First Boot on Ubuntu

1. **Check For Updates**

   ```bash
   sudo apt update && sudo apt upgrade
   ```

2. **Enable additional repositories for more software**
   - Search for Software & Updates.
   - Under the Ubuntu Software tab, make sure you have checked all of the Main, Universe, Restricted and Multiverse repository checked.
   - Move to the Other Software tab, check the option of Canonical Partners.

3. **Install All Missing / Additional Drivers**
   - Click on “Additional Drivers” Tab and follow the specific instructions provided on the screen.

4. **Installing Complete Multimedia Support**

   ```bash
   sudo apt install ubuntu-restricted-extras
   ```

5. **Improve Battery by installing TLP for Linux**

   ```bash
   sudo apt-get install tlp tlp-rdw
   ```

   Once installed, run the command below to start it:

   ```bash
   sudo tlp start
   ```

6. **Enable ‘Minimize on Click’ for the Ubuntu Dock**

   ```bash
   gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
   ```

7. **Turn On Night Light**
   - Settings > Devices > Screen Display > Night Light.

8. **Cleaning**

   ```bash
   # To remove the packages that failed to install completely,
   sudo apt-get autoclean

   # Additionally, to remove the apt-cache,
   sudo apt-get clean

   # Finally, to remove the unwanted software dependencies,
   sudo apt-get autoremove
   ```

9. **Disable Startup Applications from the gnome app list.**
   - In the Startup Application Preferences, you can disable, add or remove the programs.

10. **Opt out of data collection in Ubuntu (optional)**
    - System Settings -> Privacy and then set the Problem Reporting to Manual or you can set it to never.

11. **Auto-hide Dock**

12. **Add my profile photo to the lock screen**

13. **Disable Bluetooth From Automatically Starting At Boot**

    ```bash
    sudo systemctl disable bluetooth.service
    ```

14. **How To Set Num Lock as Default on Boot in Ubuntu**

    ```bash
    gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
    ```

15. **Deactivate Bluetooth on system startup**
    - Changing `/etc/bluetooth/main.conf` to:

      ```bash
      AutoEnable=false
      ```

16. **Always show Hidden Files**

    ```bash
    gsettings set org.gnome.nautilus.preferences show-hidden-files true
    ```

17. **Install Flatpak, [Flatpak Setup](https://flatpak.org/setup/Ubuntu)**

    ```bash
    sudo apt install flatpak
    sudo apt install gnome-software-plugin-flatpak
    ```

18. **Install Snap??**

19. **Enable Uncomplicated Firewall**

    ```bash
    sudo ufw enable
    ```

# INSTALLATION LIST

**Software app:**

- Git

  ```bash
  sudo apt-get install git-all
  ```

- Microsoft Edge


- Google Chrome

  ```
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

  sudo apt install ./google-chrome-stable_current_amd64.deb
  ```

- Visual Studio Code

  ```bash
  sudo snap install code --classic
  ```

- Thonny
  - Installed version 4.0.1, deb, from the Software app because snap didn't let me install packages on Raspberry, didn't recognize the existence of the Raspberry.

# EXTRAS

**In Thonny, to allow Raspberry to run:**

```bash
sudo usermod -a -G dialout <username>
```

**In Anaconda:**

```bash
sudo apt-get install libgl1+libglx-mesa0 libegl1 libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

libgl1+libglx-mesa0 libegl1
```

**Prevent a Package From Being Updated in Ubuntu and Debian-based Linux Distributions:**
[How to prevent a package from being updated in Ubuntu](https://itsfoss.com/prevent-package-update-ubuntu/)

**RoR setup on Ubuntu:** [GoRails](https://gorails.com/setup/ubuntu/23.10)
