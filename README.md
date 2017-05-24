# Rooting process for Google Pixel (sailfish) on May update
Scripts and files I used to backup & root my Google Pixel (sailfish) on May update

A complete guide to rooting the Google Pixel

## Libraries/Tools
### ADB and Fastboot
- Latest ADB and Fastboot: https://developer.android.com/studio/releases/platform-tools.html#download
- Yes LATEST is required! some functions needed in scripts in this repo don't exist on older versions of ADB, especially the dual-bootloader slots functionality that is new to Android
- Extract this to ~/bin (so `~/bin/platform-tools/adb` is executable) or change the variables in the scripts to point to where you extracted it to

### ABE (Android Backup Extractor)
- Only used for extracting the backup file, if you don't need to be able to restore a backup then don't bother.
- Download from: https://sourceforge.net/projects/adbextractor/
- easiest is to extract the `*.jar`s and `*.sh`s to this repo folder, or you could edit the commands to where you put it

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
First, make sure you have a terminal open in this repo folder

If you have just followed the steps above:
- reboot into the bootloader after the phone has finished starting up
- run `fastboot boot twrp-3.0.2-0-RC1-fastboot-sailfish.img` to boot into TWRP
- then have a look at the end of [`root.sh`](root.sh) for steps in TWRP (the `echo` commands)

If you have tried to get root working with some other method or Android isn't booting properly:
- run [`bash set-up.sh`](set-up.sh) once-off to download and extract the official firmware
- run [`bash root.sh`](root.sh) to flash bootloaders, system image e.t.c. (pretty much everything) and boot into TWRP. It also tells you what to do in TWRP

## Restoring the backup made from `adb backup`
The most simple command/process is to simply run this after setting up the phone (and enabling USB debugging again):
- `adb restore backup.ab`

However, in my experience this doesn't work completely, so another thing to try:
- run `bash adb-split-no-extraction.sh backup.ab` (from ABE), this will split the backup into smaller backups, one per app
- then run [`bash adb-restore.sh`](adb-restore.sh), this simply `adb restore`s all the backups individually

That didn't work for me either, next try:
- run [`bash helium-ise.sh`](helium-ise.sh) which copies the backups to a folder called `carbon` and puts them in a format that Helium can recognise
- move/copy `carbon` to /sdcard on your phone, then use the app Helium (on Google Play) to restore the backups

That didn't work for me either, next try:
- run `java -jar abe.jar unpack backup.ab backup.tar` (self-explanatory)
- run `tar -xvf backup.tar` (unpacks the tar archive), and `rm backup.tar` (removes it)
- next step is to start ADBD (the adb process on the phone) as root:
  - try running `adb root`, if this completes successfully then you're set
  - if `adb root` returns `adbd cannot run as root in production builds` as it did on my device, you will need to start ADBD in root mode some other way:
  - There is an app: "adbd insecure": https://stackoverflow.com/a/28070414/2999220
  - if that app doesn't work (didn't for me), use [`bash adb-remount-insecure.sh`](adb-remount-insecure.sh) after extracting the proper ADBD from the app apk and pushing it to /sdcard
  - if ADB doesn't pick up your phone at all even after disabling and re-enabling USB debugging, reboot your phone to reset ADBD
- run [`bash "adb push extracted apps.sh"`](adb%20push%20extracted%20apps.sh) to forcefully push the data to the phone, then set the proper permissions on the files so they can be accessed by apps
