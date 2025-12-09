#!/bin/sh
chrootStatus="OFF"
if mount | grep BlackArch &>/dev/null; then
chrootStatus="ON"
fi
echo "CHROOT STATUS $chrootStatus"
