#!/usr/bin/env bash
export adb="~/bin/platform-tools/adb"
export fastboot="~/bin/platform-tools/fastboot"

cd sailfish-n2g47o
echo "==== Flashing boot.img to both slots ===="
$fastboot flash boot_a boot.img
$fastboot flash boot_b boot.img
#bash flash-all.sh
echo "==== Flashing Bootloader ===="
$fastboot flash bootloader bootloader-sailfish-8996-012001-1703151359.img
$fastboot reboot-bootloader
sleep 5
echo "==== Flashing Radio ===="
$fastboot flash radio radio-sailfish-8996-012901-1702171013.img
$fastboot reboot-bootloader
sleep 5
echo "==== Formatting & Flashing System ===="
$fastboot -w update image-sailfish-n2g47o.zip
cd ..

read -n1 -r -p "Shut down, boot into bootloader then press enter when done..."
echo "==== Booting TWRP ===="
$fastboot boot twrp-3.0.2-0-RC1-fastboot-sailfish.img
echo "Unplug Pixel before recovery loads (i.e. now)"
echo "Once recovery has loaded up (accept the prompt), plug back in"
echo "Copy 'twrp-pixel-installer-sailfish-3.1.0-0RC2.zip', 'SR3-SuperSU-v2.79-SR3-20170114223742.zip'"
echo "  and 'VerifiedBootSigner-v8.zip' to device (via MTP)"
echo "Then flash twrp-pixel-installer-sailfish-3.1.0-0RC2.zip in TWRP"
echo "Then flash VerifiedBootSigner-v8.zip in TWRP"
echo "Then Reboot => Bootloader, press Volume down twice, then power"
echo "Then flash SR3-SuperSU-v2.79-SR3-20170114223742.zip in TWRP"
echo "Then flash VerifiedBootSigner-v8.zip in TWRP"
echo "Then Reboot => System"
