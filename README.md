# Rooting process for Google Pixel (sailfish) on May update
Scripts and files I used to backup & root my Google Pixel (sailfish) on May update

A complete guide to rooting the Google Pixel

## Libraries/Tools
platform-tools-latest-linux.zip
android-backup-extractor-20160710-bin.zip

## Bootloader
First off, if you have not already, you will have to unlock the bootloader. This wipes the device, so make sure you make a backup first!

- to allow bootloader unlocking:
  - go to <kbd>Settings</kbd> => <kbd>About phone</kbd> => tap on <kbd>Build number</kbd> 7 times to enable Developer options
  - tap back, then go to <kbd>Developer options</kbd> and turn <kbd>OEM unlocking</kbd> on
  - scroll down and enable <kbd>USB debugging</kbd> to be able to use ADB
- `adb backup -apk -all` backups apps and their data, but not the internal storage - backup that manually!
- Run `adb reboot bootloader` while your phone is in Android to reboot into the bootloader, or shut down and hold <kbd>Power</kbd> and <kbd>Volume Down</kbd> to boot into the bootloader.
- Run `fastboot oem unlock` while in bootloader, then accept prompt on phone to wipe & unlock

## Rooting
first, make sure you have a terminal open in this repo folder

If you have just followed the steps above:
- reboot into the bootloader after the phone has finished starting up
- run `fastboot boot twrp-3.0.2-0-RC1-fastboot-sailfish.img` to boot inte TWRP
- then have a look at the end of `root.sh` for steps in TWRP (the `echo` commands)

If you have tried to get root working with some other method or Android isn't booting properly:
- run `bash set-up.sh` once-off to download and extract the official firmware
- run `bash root.sh` to flash bootloaders, system image e.t.c. (pretty much everything) and boot into TWRP. it also tells you what to do in TWRP

## Restoring the backup made from `adb backup`
