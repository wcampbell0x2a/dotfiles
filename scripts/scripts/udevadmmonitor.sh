#!/bin/sh
##
# Auto mount usb devices
#
# found on: https://wiki.archlinux.org/index.php/udisks
##

pathtoname() {
    udevadm info -p /sys/"$1" | awk -v FS== '/DEVNAME/ {print $2}'
}

stdbuf -oL -- udevadm monitor --udev -s block | while read -r -- _ _ event devpath _; do
        if [ "$event" = add ]; then
            devname=$(pathtoname "$devpath")
            udisksctl mount --block-device "$devname" --no-user-interaction |& while read OUTPUT; do notify-send "udisksctl" "$OUTPUT"; done
        fi
done
