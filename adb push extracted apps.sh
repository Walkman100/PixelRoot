#!/bin/bash
## Based on https://www.semipol.de/2016/07/30/android-restoring-apps-from-twrp-backup.html
##  and my own findings on the ADB backup structure

export adb="~/bin/platform-tools/adb"
export packages=`ls apps`

# restore APK
for i in $packages; do
    if [ -d "apps/$i/a" ]; then
        $adb install -r "apps/$i/a/base.apk"
    fi
done

# restore data
for i in $packages; do
    if [ -d "apps/$i/f" ]; then
        $adb push "apps/$i/f" "/data/data/$i/files"
    fi
    if [ -d "apps/$i/db" ]; then
        $adb push "apps/$i/db" "/data/data/$i/databases"
    fi
    if [ -d "apps/$i/sp" ]; then
        $adb push "apps/$i/sp" "/data/data/$i/shared_prefs"
    fi
    if [ -d "apps/$i/r" ]; then
        $adb push "apps/$i/r" "/data/data/$i"
    fi
    if [ -d "apps/$i/ef" ]; then
        $adb push "apps/$i/ef" "/sdcard/Android/data/$i/files"
    fi
    if [ -d "apps/$i/obb" ]; then
        $adb push "apps/$i/obb" "/sdcard/Android/obb/$i"
    fi
done

# restore data permissions
## set owner
for i in $packages; do
    id=$($adb shell dumpsys package $i | grep userId)
    
    # trim `    userId=`
    id=${id:11}
    
    # take first line only (some packages report `    userId=*\n    userId=*`)
    id=${id%%$'\n'*}
    
    # if id is not empty
    if [ ! -z $id ]; then
        $adb shell chown -R $id:$id "/data/data/$i"
    fi
done
## reset SELinux perms
for i in $packages; do
    $adb shell restorecon -Rv "/data/data/$i"
done
