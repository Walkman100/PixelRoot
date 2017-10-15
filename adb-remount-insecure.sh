#!/usr/bin/env bash

export adb="$HOME/bin/platform-tools/adb"

if $adb shell [ ! -f "/sdcard/adbd" ]; then
    echo "Cannot find /sdcard/adbd on device!"
    exit 1
fi

cat > tmp.sh << EOF
setenforce 0
mount -o rw,remount /
cat /sbin/adbd > /sbin/adbd.original
chown 0.0 /sbin/adbd.original
chmod 644 /sbin/adbd.original
rm /sbin/adbd
cat /sdcard/adbd > /sbin/adbd
chown 0.0 /sbin/adbd
chmod 0750 /sbin/adbd
cat /system/bin/sh > /sbin/adbdsh
chown 0.0 /sbin/adbdsh
chmod 0750 /sbin/adbdsh
mount -o ro,remount /
stop adbd
start adbd
rm /sdcard/tmp.sh
EOF

$adb push tmp.sh /sdcard
$adb shell "su -c sh /sdcard/tmp.sh &"

rm tmp.sh
