# Omarchy Setup Guide

## BIOS and Boot Notes

If the PC is running Windows, it's mandatory to disable "Secure Boot" and recommended to disable "Fast Boot" in BIOS.

To be able to boot successfully from USB on my HP laptop, the trick is to simultaneously insert the USB flash drive and press F9, right before the screen first lights up after restart, or else the device won't appear on the boot list. On Lenovo laptops, restart the PC and press F12 (Fn+F12). I also find it best to remove any other USB devices connected to the laptop.

## Flashing the Linux Image

Flashing a Linux image typically involves using [Rufus (Portable)](https://rufus.ie/) to create a bootable USB drive or SD card with the Linux distribution's installation files. Once the image is flashed onto the drive, it becomes formatted in a filesystem format that may not be natively supported by Windows or macOS.

Windows typically uses NTFS or FAT32 filesystems, while macOS uses HFS+ or APFS. Linux distributions often use filesystems like ext4.

Here's how to fix this: [https://blog.balena.io/did-etcher-break-my-usb-sd-card/](https://blog.balena.io/did-etcher-break-my-usb-sd-card/)

### First Boot Configuration

1. Boot from the USB drive.
2. Select Keyboard Layout: "Portuguese".
3. Setup user account:
   - Username: rimedelis
   - Password: (your password)
   - Full name (used for git authentication): rimedelis
   - Email address (used for git authentication): [rimedelis@gmail.com](mailto:rimedelis@gmail.com)
   - Hostname: rimedelis-home
4. Select Timezone: Europe/Lisbon.
5. Confirm previous information.
6. Select install disk and confirm overwriting.

The installation process will take a few minutes. Once it's done, remove the USB drive and restart the computer.

### After First Boot

1. Insert the password for the user account created during installation to log in.
2. Connect to Wi-Fi network.
3. Update Omarchy.
4. Remove all pre-installed Web Apps.
5. Remove Docker TUI.
6. Change `~/.config/hypr/monitors.conf`:

   ```conf
   env = GDK_SCALE,1.25
   monitor=,preferred,auto,1.25
   ```

7. Change `~/.config/hypr/input.conf`:

   ```conf
   touchpad {
    # Use natural (inverse) scrolling
    natural_scroll = true
    # Use two-finger clicks for right-click instead of lower-right corner
    clickfinger_behavior = true
    # Control the speed of your scrolling
    scroll_factor = 0.8
   }
   ```

---

TO BE CONTINUED...
