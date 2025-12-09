#!/bin/sh

MNT="/data/local/BlackArch/rootfsBlackArch"

ChrootStatus() {
    chrootStatus="OFF"
    if mount | grep BlackArch &>/dev/null; then
        chrootStatus="ON"
    fi
}

Mount() {
    busybox mount -o remount,dev,suid /data
    
    mkdir -p "$MNT"/{dev,proc,sys,dcard,cache,data}
    
    busybox mount -o bind /dev "$MNT/dev"
    busybox mount -o bind /proc "$MNT/proc"
    busybox mount -o bind /sys "$MNT/sys"
    busybox mount -o bind /sdcard "$MNT/sdcard"
    busybox mount -o bind /dev/pts "$MNT/dev/pts"
    busybox mount -o bind /data "$MNT/data"
    busybox mount -t tmpfs tmpfs "$MNT/cache"
    
    mkdir -p "$MNT/dev/shm"
    busybox mount -t tmpfs -o size=256M tmpfs "$MNT/dev/shm"
}

Umount() {
    umount -l "$MNT/dev/pts" 2>/dev/null
    umount -l "$MNT/dev/shm" 2>/dev/null
    umount -l "$MNT/cache" 2>/dev/null
    umount -l "$MNT/sdcard" 2>/dev/null
    umount -l "$MNT/sys" 2>/dev/null
    umount -l "$MNT/proc" 2>/dev/null
    umount -l "$MNT/dev" 2>/dev/null
    umount -l "$MNT/data" 2>/dev/null
}
Chrooting() {
    #busybox chroot "$MNT" /bin/su - root
    busybox chroot "$MNT" /bin/su - chromagor
}

Cleaner() {
    unset MNT
}

while true; do
    echo "CHROOT STATUS $chrootStatus"
    echo ""
    echo "[1] Mount"
    echo "[2] Umount"
    echo "[3] Chroot"
    echo "[4] Shell"
    echo "[x] Exit"
    echo -n ">>> "
    
    read UserInput
    case $UserInput in
    1) Mount;;
    2) Umount;;
    3) clear; Chrooting;;
    4) su -c 'exec sh'; break;;
    x) break;
    esac
done
