#!/bin/bash
if command -v aria2c >/dev/null 2>&1; then
    aria2c -s 999 -j 999 -x 16 -k 1M https://dl.google.com/dl/android/aosp/sailfish-n2g47o-factory-f2bc8024.zip
else
    if [ ! -f sailfish-n2g47o-factory-f2bc8024.zip ]; then
        wget https://dl.google.com/dl/android/aosp/sailfish-n2g47o-factory-f2bc8024.zip
    fi
fi
sha256sum -c sailfish-n2g47o-factory-f2bc8024-256sum.txt
unzip sailfish-n2g47o-factory-f2bc8024.zip
unzip sailfish-n2g47o/image-sailfish-n2g47o.zip -d sailfish-n2g47o/ boot.img
