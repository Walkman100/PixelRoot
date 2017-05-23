adb shell su -c "setenforce 0
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
mount -e ro,remount /
"
