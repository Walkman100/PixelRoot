#!/usr/bin/env bash

for i in `ls split-ab`; do
    ~/bin/platform-tools/adb restore split-ab/$i
done
